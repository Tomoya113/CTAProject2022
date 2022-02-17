//
//  SearchShopsModelTests.swift
//  CTAProjectTests
//
//  Created by Tomoya Tanaka on 2022/02/09.
//

@testable import CTAProject
@testable import Moya
@testable import RxSwift
import XCTest

class SearchShopsModelTests: XCTestCase {
    typealias SearchShops = HotPepperAPI.SearchShopsModel
    let disposeBag = DisposeBag()

    // mockoloで生成されたAPIClientの型がAnyになるので、一旦mockoloを使わずにmockを作っています。
    func test_fetchShops() throws {
        let endpointClosure = { (target: MultiTarget) -> Endpoint in
            return APIMockHelper.generateEndpointClosure(
                target: target,
                sampleResponse: .response(
                    APIMockHelper.httpURLResponse(target: target, statusCode: 200),
                    SearchShops.exampleJSON.data(using: .utf8)!
                )
            )
        }
        let stubbingProvider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)

        let model = SearchShopsModel(provider: stubbingProvider)

        model.fetchShops(keyword: "dummy")
            .subscribe(onNext: { shops in
                XCTAssertEqual(shops[0].name, "もつ鍋 焼き肉 岩見 西新店")
            })
            .disposed(by: disposeBag)
    }
}
