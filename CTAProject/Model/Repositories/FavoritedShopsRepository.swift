//
//  FavoritedShopsRepository.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/03/21.
//

import Foundation
import RealmSwift
import RxSwift

/// @mockable
protocol FavoritedShopsRepositoryType {
    func checkIfShopFavorited(_ id: String) -> Bool
    func addFavoriteShop(_ favoriteShop: FavoriteShop) -> Single<FavoriteShop>
    func removeFavoriteShop(_ id: String) -> Single<Void>
}

final class FavoritedShopsRepository: FavoritedShopsRepositoryType {

    private let realm: Realm

    init(realm: Realm) {
        self.realm = realm
    }

    func checkIfShopFavorited(_ id: String) -> Bool {
        var isFavorited = false
        let object = realm.object(ofType: FavoriteShop.self, forPrimaryKey: id)
        if object != nil { isFavorited = true }
        return isFavorited
    }

    func addFavoriteShop(_ favoriteShop: FavoriteShop) -> Single<FavoriteShop> {
        let object = realm.object(ofType: FavoriteShop.self, forPrimaryKey: favoriteShop.id)
        guard object == nil else {
            return Single<FavoriteShop>.error(RealmError.idIsAlreadyTaken)
        }
        do {
            try realm.write {
                realm.add(favoriteShop)
            }
            return Single<FavoriteShop>.just(favoriteShop)
        } catch let error as NSError {
            return Single<FavoriteShop>.error(error)
        }
    }

    func removeFavoriteShop(_ id: String) -> Single<Void> {
        let object = realm.object(ofType: FavoriteShop.self, forPrimaryKey: id)
        guard let object = object else {
            return Single<Void>.error(RealmError.objectIsNotFound)
        }
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch let error {
            return Single<Void>.error(error)
        }
        return Single<Void>.just(())
    }
}
