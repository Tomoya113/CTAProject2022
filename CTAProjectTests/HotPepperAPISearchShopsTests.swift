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
    static let keyword = "焼き肉"
    let disposeBag = DisposeBag()
    let targetType = HotPepperAPI.Request.SearchShops(keyword: keyword)
    
    typealias Response = HotPepperAPI.Response
    typealias SearchShops = HotPepperAPI.SearchShopsModel
    typealias ErrorModel = HotPepperAPI.ErrorModel
    
    func test_APIResponseSuccess() {
        let endpointClosure = { (target: MultiTarget) -> Endpoint in
            return Self.generateEndpointClosure(
                target: target,
                sampleResponse: .response(
                    Self.httpURLResponse(target: target, statusCode: 200),
                    SearchShops.exampleJSON.data(using: .utf8)!
                )
            )
        }
        let stubbingProvider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        XCTAssertEqual(targetType.queryParameters["name_any"], Self.keyword)
        
        APIClient.shared
            .send(provider: stubbingProvider, targetType).subscribe(
                onSuccess: { result in
                    switch result {
                    case .success(let response):
                        XCTAssertEqual(response.results.shop[0].name, "もつ鍋 焼き肉 岩見 西新店")
                    default:
                        XCTFail("failed: \(result)")
                    }
                }
            )
            .disposed(by: disposeBag)
    }
    
    func test_APIResponseIsNot2XX() {
        let endpointClosure = { (target: MultiTarget) -> Endpoint in
            return Self.generateEndpointClosure(
                target: target,
                sampleResponse: .response(
                    Self.httpURLResponse(target: target, statusCode: 3000),
                    ErrorModel.exampleJSON.data(using: .utf8)!
                )
            )
        }
        let stubbingProvider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        
        APIClient.shared
            .send(provider: stubbingProvider, targetType).subscribe(
                onSuccess: { result in
                    switch result {
                    case .statusCodeIsNot2XX(let response):
                        XCTAssertEqual(response.results.error[0].code, 3000)
                        XCTAssertEqual(response.results.error[0].message, "少なくとも１つの条件を入れてください。")
                    default:
                        XCTFail()
                    }
                },
                onFailure: { error in
                    XCTFail()
                }).disposed(by: disposeBag)
    }
    
    func test_APIResponseMoyaError() {
        let endpointClosure = { (target: MultiTarget) -> Endpoint in
            return Self.generateEndpointClosure(
                target: target,
                sampleResponse: .networkError(NSError(domain: "networkError", code: 300, userInfo: nil)))
        }
        let stubbingProvider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        
        APIClient.shared
            .send(provider: stubbingProvider, targetType).subscribe(
                onSuccess: { result in
                    switch result {
                    case .moyaError(let moyaError):
                        XCTAssertEqual(moyaError.localizedDescription, "操作を完了できませんでした。（networkErrorエラー300）")
                    default:
                        XCTFail()
                    }
                },
                onFailure: { error in
                    XCTFail()
                }).disposed(by: disposeBag)
    }
}

extension HotPepperAPISearchShopsTests {
    static func generateEndpointClosure(target: MultiTarget, sampleResponse: EndpointSampleResponse) -> Endpoint {
        return Endpoint(
            url: URL(target: target).absoluteString,
            sampleResponseClosure: {
                sampleResponse
            },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
    
    static func httpURLResponse(target: MultiTarget, statusCode: Int) -> HTTPURLResponse {
        return HTTPURLResponse(
            url: URL(target: target),
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
    }
}
