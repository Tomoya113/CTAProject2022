//
//  TargetType.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/20.
//

import Foundation
import Moya

protocol HotPepperAPITargetType: BaseTargetType {
    var baseQueryParameters: [String: String] { get }
}

extension HotPepperAPITargetType {
    var baseURL: URL {
        return URL(string: "https://webservice.recruit.co.jp")!
    }
    
    var baseQueryParameters: [String: String] {
        return [
            "key": Environments.APIKey.HotPepper.rawValue,
            "format": "json",
        ]
    }
}
