//
//  SearchShopsViewModel.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/02/03.
//

import Foundation
import RxCocoa
import RxRelay
import RxSwift

// NOTE: 外部から受ける命令
protocol SearchShopsViewModelInputs {
    var searchWord: AnyObserver<String> { get }
    var tapFavoriteButton: AnyObserver<IndexPath> { get }
}

// NOTE: 外部に渡す値
protocol SearchShopsViewModelOutputs: SearchShops {
    var shops: Driver<[SearchShopsTableViewCellData]> { get }
    var loading: Driver<Bool> { get }
    var hasSearchWordCountExceededError: Driver<Bool> { get }
    var didPressFavoriteButton: Driver<IndexPath> { get }
}

protocol SearchShopsViewModelType {
    var inputs: SearchShopsViewModelInputs { get }
    var outputs: SearchShopsViewModelOutputs { get }
}

final class SearchShopsViewModel: SearchShopsViewModelInputs, SearchShopsViewModelOutputs {

    var searchWord: AnyObserver<String>
    var tapFavoriteButton: AnyObserver<IndexPath>
    var shops: Driver<[SearchShopsTableViewCellData]>
    var loading: Driver<Bool>
    var hasSearchWordCountExceededError: Driver<Bool>
    var didPressFavoriteButton: Driver<IndexPath>

    private var disposeBag = DisposeBag()

    init(model: SearchShopsModelType) {
        let _searchWord = PublishRelay<String>()
        let _tapFavoriteButton = PublishRelay<IndexPath>()

        let _shops = BehaviorRelay<[SearchShopsTableViewCellData]>(value: [])
        let _loading = PublishRelay<Bool>()
        let _hasSearchWordCountExceededError = PublishRelay<Bool>()
        let _didPressFavoriteButton = PublishRelay<IndexPath>()

        // MARK: Input
        searchWord = AnyObserver<String> { event in
            guard let keyword = event.element else { return }
            _searchWord.accept(keyword)
        }
        tapFavoriteButton = AnyObserver<IndexPath> { event in
            guard let tapFavoriteButton = event.element else { return }
            _tapFavoriteButton.accept(tapFavoriteButton)
        }

        // MARK: Output
        shops = _shops.asDriver()
        loading = _loading.asDriver(onErrorJustReturn: false)
        hasSearchWordCountExceededError = _hasSearchWordCountExceededError.asDriver(onErrorDriveWith: .empty())
        didPressFavoriteButton = _didPressFavoriteButton.asDriver(onErrorDriveWith: .empty())

        // MARK: SearchQuery
        let searchWordValidationResult = _searchWord.flatMap { searchWord -> Observable<SearchWordValidator.ValidationResult> in
            return .just(SearchWordValidator.validate(searchWord))
        }
        .share()

        searchWordValidationResult
            .filterExceededWordCount()
            .bind(to: _hasSearchWordCountExceededError)
            .disposed(by: disposeBag)

        let searchResult = searchWordValidationResult
            .filterValid()
            .flatMap { searchWord -> Single<[SearchShopsTableViewCellData]> in
                _loading.accept(true)
                return model.fetchShops(keyword: searchWord)
            }
            .share()

        searchResult
            .map { _ -> Bool in false }
            .bind(to: _loading)
            .disposed(by: disposeBag)

        searchResult
            .bind(to: _shops)
            .disposed(by: disposeBag)

        // MARK: OnSelectedCell
        let selectedCell = _tapFavoriteButton.flatMap { indexPath -> Observable<(SearchShopsTableViewCellData, IndexPath)> in
            let shop = _shops.value[indexPath.row]
            return Observable.combineLatest(Observable.just(shop), Observable.just(indexPath))
        }
        .share()

        selectedCell
            .filter { (shop, _) in !shop.favorited }
            .flatMap { (shop, indexPath) -> Single<IndexPath> in
                return model.addFavoriteShop(FavoriteShop(shop))
                    .map { _ in return indexPath }
            }
            .bind(to: _didPressFavoriteButton)
            .disposed(by: disposeBag)

        selectedCell
            .filter { (shop, _) in shop.favorited }
            .flatMap { (shop, indexPath) -> Single<IndexPath> in
                return model.removeFavoriteShop(shop.id)
                    .map { _ in return indexPath }
            }
            .bind(to: _didPressFavoriteButton)
            .disposed(by: disposeBag)

        _didPressFavoriteButton
            .map { indexPath in
                var shops = _shops.value
                shops[indexPath.row].favorited = !shops[indexPath.row].favorited
                _shops.accept(shops)
            }
            .subscribe()
            .disposed(by: disposeBag)

    }
}

extension SearchShopsViewModel: SearchShopsViewModelType {
    var inputs: SearchShopsViewModelInputs { return self }
    var outputs: SearchShopsViewModelOutputs { return self }
}
