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

        dependency.searchShopsModelMock.fetchShopsHandler = { keyword in
            return Single.just(Self.expectedData)
        }

        let shops = WatchStream(dependency.testTarget.outputs.shops.asObservable())
        let loading = WatchStream(dependency.testTarget.outputs.loading.asObservable())

        dependency.testTarget.inputs.searchWord.onNext("searchQuery")
        dependency.testScheduler.start()

        let shopResult = shops.observer.events.map { $0.value.element }
        let loadingResult = loading.observer.events.map { $0.value.element }

        XCTAssertEqual(shopResult[shopResult.count - 1]?.count, Self.expectedData.count)
        XCTAssertEqual(shopResult.last??.count, Self.expectedData.count)
        XCTAssertEqual(loadingResult, [true, false])
    }

    func test_searchWordInputFailure() throws {
        let dependency = Dependency()

        let shops = WatchStream(dependency.testTarget.outputs.shops.asObservable())
        let loading = WatchStream(dependency.testTarget.outputs.loading.asObservable())
        let hasSearchWordCountExceededError = WatchStream(dependency.testTarget.outputs.hasSearchWordCountExceededError.asObservable())

        dependency.testTarget.inputs.searchWord.onNext(SearchShopsViewModelTests.invalidSearchWord)
        dependency.testScheduler.start()

        let shopResult = shops.observer.events.map { $0.value.element }
        let loadingResult = loading.observer.events.map { $0.value.element }
        let hasSearchWordCountExceededErrorResult = hasSearchWordCountExceededError.observer.events.map { $0.value.element }

        XCTAssertEqual(shopResult.count, 1)
        XCTAssertTrue(loadingResult.isEmpty)
        XCTAssertEqual(hasSearchWordCountExceededErrorResult, [true])
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
        }
    }
}

extension SearchShopsViewModelTests: SearchShops {
    typealias Budget = HotPepperAPI.Budget
    static var invalidSearchWord = "テキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキスト"
    static var expectedData: Shops {
        return [
            Shop(
                stationName: "西新",
                name: "もつ鍋 焼き肉 岩見 西新店",
                budget: Budget(name: "3001～4000円"),
                logoImage: "https://imgfp.hotp.jp/IMGH/93/76/P035429376/P035429376_69.jpg"
            ),
        ]
    }
}

