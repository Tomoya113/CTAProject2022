//
//  SearchShopsModel.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/02/05.
//
import Foundation
import Moya
import RxSwift

/// @mockable
protocol SearchShopsModelType: SearchShops {
    func fetchShops(keyword: String) -> Observable<Shops>
}

final class SearchShopsModel: SearchShopsModelType {

    var provider: MoyaProvider<MultiTarget>

    init(
        provider: MoyaProvider<MultiTarget> = MoyaProvider<MultiTarget>()
    ) {
        self.provider = provider
    }

    func fetchShops(keyword: String) -> Observable<Shops> {
        let targetType = HotPepperAPI.Request.SearchShops(keyword: keyword)
        return APIClient.shared
            .send(provider: provider, targetType)
            .asObservable()
            .flatMap { result -> Observable<Shops> in
                switch result {
                case .success(let response):
                    return .just(response.results.shop)
                default:
                    return .empty()
                }
            }
    }
}
