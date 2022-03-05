//
//  ShopsRepository.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/02/21.
//

import Foundation
import Moya
import RxSwift

/// @mockable
protocol SearchShopsRepositoryType: SearchShops {
    func fetchShops(keyword: String) -> Single<Shops>
}

final class SearchShopsRepository: SearchShopsRepositoryType {
    let provider: MoyaProvider<MultiTarget>

    init(
        provider: MoyaProvider<MultiTarget> = MoyaProvider<MultiTarget>()
    ) {
        self.provider = provider
    }

    func fetchShops(keyword: String) -> Single<Shops> {
        let targetType = HotPepperAPI.Request.SearchShops(keyword: keyword)
        return APIClient.shared
            .send(provider: provider, targetType)
            .flatMap { result -> Single<HotPepperAPI.SearchShopsModel> in
                switch result {
                case .success(let response):
                    return .just(response.results)
                default:
                    return .never()
                }
            }
            .map { result in
                return result.shop
            }
    }
}
