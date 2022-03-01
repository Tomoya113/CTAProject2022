//
//  SearchShopsModelTests.swift
//  CTAProjectTests
//
//  Created by Tomoya Tanaka on 2022/02/09.
//

@testable import CTAProject
@testable import Moya
@testable import RxSwift
@testable import RxTest
import XCTest

class SearchShopsModelTests: XCTestCase {
    typealias SearchShops = HotPepperAPI.SearchShopsModel

    // mockoloで生成されたAPIClientの型がAnyになるので、一旦mockoloを使わずにmockを作っています。
    func test_fetchShops() throws {
        let dependency = Dependency()
        let fetchShops = WatchStream(dependency.testTarget.fetchShops(keyword: "dummy").asObservable())
        dependency.testScheduler.start()
        // NOTE: WatchStreamのvalueを使うとcompletedが返ってきてしまうのでeventsをmapしています
        let fetchShopsResult = fetchShops.observer.events.map { $0.value.element }
        XCTAssertEqual(fetchShopsResult.first??.first?.name, "もつ鍋 焼き肉 岩見 西新店")
    }
}

extension SearchShopsModelTests {
    struct Dependency {
        let testScheduler: TestScheduler
        let testTarget: SearchShopsModelType
        let stubbingProvider: MoyaProvider<MultiTarget>

        init() {
            testScheduler = TestScheduler(initialClock: 0)
            let endpointClosure = { (target: MultiTarget) -> Endpoint in
                return APIMockHelper.generateEndpointClosure(
                    target: target,
                    sampleResponse: .response(
                        APIMockHelper.httpURLResponse(target: target, statusCode: 200),
                        SearchShops.exampleJSON.data(using: .utf8)!
                    )
                )
            }
            stubbingProvider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)

            let searchShopsRepository = SearchShopsRepository(provider: stubbingProvider)
            testTarget = SearchShopsModel(searchShopsRepository: searchShopsRepository)
        }
    }
}
