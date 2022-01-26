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
    
    func test_SearchShopsModel() throws {
        let decode = JSONDecoder()
        decode.keyDecodingStrategy = .convertFromSnakeCase
        XCTAssertNoThrow(try decode.decode(HotPepperAPI.Response<HotPepperAPI.SearchShopsModel>.self, from: HotPepperAPI.SearchShopsModel.exampleJSON.data(using: .utf8)!))
        
    }
    
    func test_ErrorModel() throws {
        let decode = JSONDecoder()
        decode.keyDecodingStrategy = .convertFromSnakeCase
        XCTAssertNoThrow(try decode.decode(HotPepperAPI.Response<HotPepperAPI.ErrorModel>.self, from: HotPepperAPI.ErrorModel.exampleJSON.data(using: .utf8)!))
    }
    
}

