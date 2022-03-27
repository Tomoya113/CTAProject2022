//
//  SearchShopsViewModelTests.swift
//  CTAProjectTests
//
//  Created by Tomoya Tanaka on 2022/02/09.
//

@testable import CTAProject
@testable import Moya
@testable import RxRelay
@testable import RxSwift
@testable import RxTest
import XCTest

class SearchShopsViewModelTests: XCTestCase {

    func test_searchWordInputSuccess() throws {
        let dependency = Dependency()

        let shops = WatchStream(dependency.testTarget.outputs.shops.asObservable())
        let loading = WatchStream(dependency.testTarget.outputs.loading.asObservable())

        dependency.testTarget.inputs.searchWord.onNext("searchQuery")

        XCTAssertEqual(shops.result.last??.count, Self.expectedData.count)
        XCTAssertEqual(loading.result, [true, false])
    }

    func test_searchWordInputFailure() throws {
        let dependency = Dependency()

        let shops = WatchStream(dependency.testTarget.outputs.shops.asObservable())
        let loading = WatchStream(dependency.testTarget.outputs.loading.asObservable())
        let hasSearchWordCountExceededError = WatchStream(dependency.testTarget.outputs.hasSearchWordCountExceededError.asObservable())

        dependency.testTarget.inputs.searchWord.onNext(SearchShopsViewModelTests.invalidSearchWord)

        XCTAssertEqual(shops.result.count, 1)
        XCTAssertTrue(loading.result.isEmpty)
        XCTAssertEqual(hasSearchWordCountExceededError.result, [true])
    }

    func test_tapFavoriteButton() throws {
        let dependency = Dependency()

        let shops = WatchStream(dependency.testTarget.outputs.shops.asObservable())
        let didPressFavoriteButton = WatchStream(dependency.testTarget.outputs.didPressFavoriteButton.asObservable())

        dependency.testTarget.inputs.searchWord.onNext("searchQuery")
        dependency.testTarget.inputs.tapFavoriteButton.onNext(IndexPath(row: Self.expectedData.count - 1, section: 1))

        XCTAssertEqual(shops.result.last??.last?.favorited, true)
        XCTAssertEqual(didPressFavoriteButton.result.count, 1)

    }
}

extension SearchShopsViewModelTests {
    struct Dependency {
        let testScheduler: TestScheduler
        let testTarget: SearchShopsViewModel
        let searchShopsModelMock: SearchShopsModelTypeMock

        init() {
            testScheduler = TestScheduler(initialClock: 0)
            searchShopsModelMock = SearchShopsModelTypeMock()
            testTarget = SearchShopsViewModel(model: searchShopsModelMock)

            searchShopsModelMock.fetchShopsHandler = { keyword in
                return Single.just(SearchShopsViewModelTests.expectedData)
            }

            searchShopsModelMock.removeFavoriteShopHandler = { id in
                return Single.just(())
            }

            searchShopsModelMock.addFavoriteShopHandler = { shop in
                return Single.just(FavoriteShop.exampleInstance)
            }
        }
    }
}

extension SearchShopsViewModelTests: SearchShops {
    typealias Budget = HotPepperAPI.Budget
    static var invalidSearchWord = String(repeating: "テキスト", count: 15)
    static var expectedData: [SearchShopsTableViewCellData] {
        return [
            SearchShopsTableViewCellData.exampleInstance
        ]
    }
}
