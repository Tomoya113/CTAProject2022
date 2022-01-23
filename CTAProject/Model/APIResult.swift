//
//  APIResult.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/23.
//

import Foundation

enum APIResult<T, E> {
    case success(T)
    case error(E)
}

