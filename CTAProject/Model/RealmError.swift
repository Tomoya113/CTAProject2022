//
//  RealmError.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/03/24.
//

import Foundation

enum RealmError: Error {
    case objectIsNotFound
    case idIsAlreadyTaken
}

extension RealmError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .objectIsNotFound:
            return "object is not found"
        case .idIsAlreadyTaken:
            return "id is already taken"
        }
    }
}
