//
//  UnexpectedError.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/25.
//

import Foundation

struct UnexpectedError: Error {}

extension UnexpectedError: LocalizedError {
    var errorDescription: String? {
        return "unexpected error"
    }
}
