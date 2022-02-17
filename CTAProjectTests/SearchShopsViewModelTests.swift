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

    func test_normalUseCase() throws {
        let dependency = Dependency()

        dependency.searchShopsModelMock.fetchShopsHandler = { keyword in
            return Observable.of(Self.expectedData)
        }

        let keywordEvent = dependency.testScheduler.createHotObservable([
            Recorded.next(10, "keyword")
        ]).asObservable()

        let shopsObserver = dependency.testScheduler.createObserver(Shops.self)
        let loadingObserver = dependency.testScheduler.createObserver(Bool.self)

        keywordEvent
            .bind(to: dependency.testTarget.keyword)
            .disposed(by: dependency.disposeBag)

        dependency.testTarget.outputs.shops
            .asObservable()
            .bind(to: shopsObserver)
            .disposed(by: dependency.disposeBag)

        dependency.testTarget.outputs.loading
            .asObservable()
            .bind(to: loadingObserver)
            .disposed(by: dependency.disposeBag)

        dependency.testScheduler.start()

        let shopResult = shopsObserver.events.map { $0.value.element }
        let loadingResult = loadingObserver.events.map { $0.value.element }

        XCTAssertEqual(shopResult[shopResult.count - 1]?.count, Self.expectedData.count)
        XCTAssertEqual(loadingResult, [true, false])
    }
}

extension SearchShopsViewModelTests {
    struct Dependency {
        let disposeBag: DisposeBag
        let testScheduler: TestScheduler
        let testTarget: SearchShopsViewModel
        let searchShopsModelMock: SearchShopsModelTypeMock

        init() {
            disposeBag = DisposeBag()
            testScheduler = TestScheduler(initialClock: 0)
            searchShopsModelMock = SearchShopsModelTypeMock()
            testTarget = SearchShopsViewModel(model: searchShopsModelMock)
        }
    }
}

extension SearchShopsViewModelTests: SearchShops {
    typealias Budget = HotPepperAPI.Budget
    static var expectedData: Shops {
        return [
            Shop(
                stationName: "西新",
                name: "もつ鍋 焼き肉 岩見 西新店",
                budget: Budget(name: "3001～4000円"),
                logoImage: "https://imgfp.hotp.jp/IMGH/93/76/P035429376/P035429376_69.jpg"
            ),
            Shop(
                stationName: "別府",
                name: "焼き肉 凡",
                budget: Budget(name: "3001～4000円"),
                logoImage: "https://imgfp.hotp.jp/IMGH/80/69/P038308069/P038308069_69.jpg"
            ),
            Shop(
                stationName: "鹿児島中央駅前",
                name: "松坂 焼き肉",
                budget: Budget(name: "5001～7000円"),
                logoImage: "https://imgfp.hotp.jp/IMGH/48/29/P027814829/P027814829_69.jpg"
            ),
        ]
    }
}

