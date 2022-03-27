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
    func fetchShops(keyword: String) -> Single<[SearchShopsTableViewCellData]>
    func addFavoriteShop(_ favoriteShop: FavoriteShop) -> Single<FavoriteShop>
    func removeFavoriteShop(_ id: String) -> Single<Void>
}

final class SearchShopsModel: SearchShopsModelType {

    let searchShopsRepository: SearchShopsRepositoryType
    let favoritedShopsRepository: FavoritedShopsRepositoryType

    init(
        searchShopsRepository: SearchShopsRepositoryType,
        favoritedShopsRepository: FavoritedShopsRepositoryType
    ) {
        self.searchShopsRepository = searchShopsRepository
        self.favoritedShopsRepository = favoritedShopsRepository
    }

    func fetchShops(keyword: String) -> Single<[SearchShopsTableViewCellData]> {
        return searchShopsRepository.fetchShops(keyword: keyword)
            .map { [favoritedShopsRepository] shops in
                shops.map {
                    return SearchShopsTableViewCellData(
                        id: $0.id,
                        shopName: $0.name,
                        locationName: $0.stationName,
                        price: $0.budget.name,
                        shopImageURL: $0.logoImage,
                        favorited: favoritedShopsRepository.checkIfShopFavorited($0.id)
                    )
                }
            }
    }

    func addFavoriteShop(_ favoriteShop: FavoriteShop) -> Single<FavoriteShop> {
        return favoritedShopsRepository.addFavoriteShop(favoriteShop)
    }

    func removeFavoriteShop(_ id: String) -> Single<Void> {
        return favoritedShopsRepository.removeFavoriteShop(id)
    }

}
