//
//  Error.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/20.
//

import Foundation

extension HotPepperAPI {
    struct ErrorModel: Decodable {
        let error: [Error]
    }
    
    struct Error: Decodable {
        let code: Int
        let message: String
    }
}

extension HotPepperAPI.ErrorModel {
    static var exampleJSON: String {
        """
        {
           "results":{
              "api_version":"1.26",
              "error":[
                 {
                    "code":3000,
                    "message":"少なくとも１つの条件を入れてください。"
                 }
              ]
           }
        }
        """
    }
}
