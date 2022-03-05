//
//  BaseTargetType.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/21.
//

import Foundation
import Moya

protocol BaseTargetType: TargetType {
    associatedtype Response: Decodable
    associatedtype ErrorResponse: Decodable
}
