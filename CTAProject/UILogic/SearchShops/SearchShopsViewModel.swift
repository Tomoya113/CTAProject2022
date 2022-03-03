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
}

// NOTE: 外部に渡す値
protocol SearchShopsViewModelOutputs: SearchShops {
    var shops: Driver<Shops> { get }
    var loading: Driver<Bool> { get }
    var hasSearchWordCountExceededError: Driver<Bool> { get }
}

protocol SearchShopsViewModelType {
    var inputs: SearchShopsViewModelInputs { get }
    var outputs: SearchShopsViewModelOutputs { get }
}

final class SearchShopsViewModel: SearchShopsViewModelInputs, SearchShopsViewModelOutputs {

    var searchWord: AnyObserver<String>
    var shops: Driver<Shops>
    var loading: Driver<Bool>
    var hasSearchWordCountExceededError: Driver<Bool>

    private var disposeBag = DisposeBag()

    init(model: SearchShopsModelType) {
        let _searchWord = PublishRelay<String>()
        let _shops = BehaviorRelay<Shops>(value: [])
        let _loading = PublishRelay<Bool>()
        let _hasSearchWordCountExceededError = PublishRelay<Bool>()

        searchWord = AnyObserver<String> { event in
            guard let keyword = event.element else { return }
            _searchWord.accept(keyword)
        }
        shops = _shops.asDriver()
        loading = _loading.asDriver(onErrorJustReturn: false)
        hasSearchWordCountExceededError = _hasSearchWordCountExceededError.asDriver(onErrorDriveWith: .empty())

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
            .flatMap { searchWord -> Single<Shops> in
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

    }
}

extension SearchShopsViewModel: SearchShopsViewModelType {
    var inputs: SearchShopsViewModelInputs { return self }
    var outputs: SearchShopsViewModelOutputs { return self }
}
