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
    func fetchShops(keyword: String) -> Single<Shops>
}

final class SearchShopsModel: SearchShopsModelType {

    let searchShopsRepository: SearchShopsRepositoryType

    init(
        searchShopsRepository: SearchShopsRepositoryType
    ) {
        self.searchShopsRepository = searchShopsRepository
    }

    func fetchShops(keyword: String) -> Single<Shops> {
        return searchShopsRepository.fetchShops(keyword: keyword)
    }
}
