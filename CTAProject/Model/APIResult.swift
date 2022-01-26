//
//  APIResult.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/23.
//

import Foundation

enum APIResult<T: Decodable, E: Decodable> {
    case success(T)
    //NOTE: APIからエラーのレスポンスが帰ってきた時(200...299)以外
    case apiError(E)
}

