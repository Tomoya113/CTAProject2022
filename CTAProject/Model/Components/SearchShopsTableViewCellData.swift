//
//  SearchShopsTableViewCellData.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/03/14.
//

import RxDataSources

typealias SearchShopsTableViewSection = SearchShopsTableViewCell.SearchShopsTableViewSection
typealias SearchShopsTableViewCellData = SearchShopsTableViewCell.SearchShopsTableViewCellData

extension SearchShopsTableViewCell {
    struct SearchShopsTableViewCellData {
        let id: String
        let shopName: String
        let locationName: String
        let price: String
        let shopImageURL: String
        var favorited: Bool
    }

    struct SearchShopsTableViewSection {
        var items: [SearchShopsTableViewCellData]
    }

}

extension SearchShopsTableViewSection: SectionModelType {
    typealias Item = SearchShopsTableViewCellData
    init (original: Self, items: [Item]) {
        self = original
        self.items = items
    }
}

extension SearchShopsTableViewCellData {
    static var exampleInstance: SearchShopsTableViewCellData {
        return SearchShopsTableViewCellData(
            id: "id",
            shopName: "shopName",
            locationName: "locationName",
            price: "price",
            shopImageURL: "shopImageURL",
            favorited: false
        )
    }
}
