//
//  Request.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/20.
//

import Foundation
import Moya

extension HotPepperAPI {
    struct Request {
        struct SearchShops: HotPepperAPITargetType {
            typealias Response = HotPepperAPI.Response<HotPepperAPI.SearchShopsModel>
            typealias ErrorResponse = HotPepperAPI.Response<HotPepperAPI.ErrorModel>
            
            let keyword: String
            
            init(keyword: String) {
                self.keyword = keyword
            }
            
            var path: String {
                return "/hotpepper/gourment/v1/"
            }
            
            var method: Moya.Method {
                return .get
            }
            
            var task: Task {
                return .requestParameters(
                    parameters: queryParameters,
                    encoding: URLEncoding.default
                )
            }
            
            var headers: [String : String]? {
                return nil
            }
            
            var queryParameters: [String: String] {
                return baseQueryParameters.merging([
                    "name_any": keyword
                ]) { $1 }
            }
            
            var sampleData: Data {
                return HotPepperAPI.SearchShopsModel.exampleJSON.data(using: String.Encoding.utf8)!
            }
            
        }
    }
}


