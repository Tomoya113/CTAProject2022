//
//  HotPepperAPIModelTests.swift
//  CTAProjectTests
//
//  Created by Tomoya Tanaka on 2022/01/22.
//

import XCTest
import Foundation
@testable import CTAProject
@testable import Moya
@testable import RxSwift

class HotPepperAPIModelTests: XCTestCase {
    
    func testSearchShopsModel() throws {
        let decode = JSONDecoder()
        decode.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let response = try decode.decode(HotPepperAPI.Response<HotPepperAPI.SearchShopsModel>.self, from: HotPepperAPI.SearchShopsModel.exampleJSON.data(using: .utf8)!)
            XCTAssertEqual(response.results.shop[0].name, "もつ鍋 焼き肉 岩見 西新店")
        } catch let error {
            XCTFail("error \(error)")
        }
        
    }
    
    func testErrorModel() throws {
        let decode = JSONDecoder()
        decode.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let response = try decode.decode(HotPepperAPI.Response<HotPepperAPI.ErrorModel>.self, from: HotPepperAPI.ErrorModel.exampleJSON.data(using: .utf8)!)
            XCTAssertEqual(response.results.error[0].message, "少なくとも１つの条件を入れてください。")
            XCTAssertEqual(response.results.error[0].code, 3000)
        } catch let error {
            XCTFail("error \(error)")
        }
    }
    
}
