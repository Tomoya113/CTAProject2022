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
    var keyword: AnyObserver<String> { get }
}

// NOTE: 外部に渡す値
protocol SearchShopsViewModelOutputs: SearchShops {
    var shops: Driver<Shops> { get }
    var loading: Driver<Bool> { get }
}

protocol SearchShopsViewModelType {
    var inputs: SearchShopsViewModelInputs { get }
    var outputs: SearchShopsViewModelOutputs { get }
}

final class SearchShopsViewModel: SearchShopsViewModelInputs, SearchShopsViewModelOutputs {

    var keyword: AnyObserver<String>
    var shops: Driver<Shops>
    var loading: Driver<Bool>

    private var disposeBag = DisposeBag()

    init(model: SearchShopsModelType) {
        let _keyword = PublishRelay<String>()
        let _shops = BehaviorRelay<Shops>(value: [])
        let _loading = PublishRelay<Bool>()

        keyword = AnyObserver<String> { event in
            guard let keyword = event.element else { return }
            _keyword.accept(keyword)
        }
        shops = _shops.asDriver()
        loading = _loading.asDriver(onErrorJustReturn: false)

        let searchResult = _keyword.flatMap { keyword -> Observable<Shops> in
            _loading.accept(true)
            return model.fetchShops(keyword: keyword)
        }
            .share()

        searchResult
            .subscribe(onNext: { _ in
                _loading.accept(false)
            })
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
