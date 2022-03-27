//
//  FavoriteShop.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/03/21.
//

import Foundation
import RealmSwift

class FavoriteShop: Object {
    @Persisted var id: String = ""
    @Persisted var stationName: String = ""
    @Persisted var name: String = ""
    @Persisted var budget: Budget?
    @Persisted var logoImage: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(_ shop: SearchShopsTableViewCellData) {
        self.init()
        id = shop.id
        stationName = shop.locationName
        name = shop.shopName
        budget = .init(shop.price)
        logoImage = shop.shopImageURL
    }
}

class Budget: EmbeddedObject {
    @Persisted var name: String
    
    convenience init(_ price: String) {
        self.init()
        name = price
    }
}


extension FavoriteShop {
    static var exampleInstance: FavoriteShop {
        return FavoriteShop(SearchShopsTableViewCellData.exampleInstance)
    }
}
