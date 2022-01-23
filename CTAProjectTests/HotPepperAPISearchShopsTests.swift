//
//  HotPepperAPISearchShopsTests.swift
//  CTAProjectTests
//
//  Created by Tomoya Tanaka on 2022/01/22.
//

import XCTest
@testable import CTAProject
@testable import Moya
@testable import RxSwift

class HotPepperAPISearchShopsTests: XCTestCase {
    let disposeBag = DisposeBag()
    let targetType = HotPepperAPI.Request.SearchShops(keyword: "焼き肉")
    
    func testSuccess() {
        let stubbingProvider = MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.immediatelyStub)
        
        XCTAssertEqual(targetType.queryParameters["name_any"], "焼き肉")
        
        APIClient.shared
            .send(provider: stubbingProvider, targetType).subscribe(onNext: { result in
                switch(result) {
                case .success(let response):
                    print(self.targetType.path)
                    XCTAssertEqual(response.results.shop[0].name, "もつ鍋 焼き肉 岩見 西新店")
                default:
                    XCTFail("failed: \(result)")
                }
            }).disposed(by: disposeBag)
    }
    
    func testAPIError() {
        let customEndpointClosure = { (target: MultiTarget) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(3000, HotPepperAPI.ErrorModel.exampleJSON.data(using: .utf8)! )},
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        let stubbingProvider = MoyaProvider<MultiTarget>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        
        APIClient.shared
            .send(provider: stubbingProvider, targetType).subscribe(onNext: { result in
                switch(result) {
                case .error(let error):
                    XCTAssertEqual(error.results.error[0].code, 3000)
                    XCTAssertEqual(error.results.error[0].message, "少なくとも１つの条件を入れてください。")
                default:
                    XCTFail("failed: \(result)")
                }
            }).disposed(by: disposeBag)
    }
    
}
