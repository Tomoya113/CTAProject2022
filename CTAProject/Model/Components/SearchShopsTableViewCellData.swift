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
        let shopName: String
        let locationName: String
        let price: String
        let shopImageURL: String
        let favorited: Bool
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
