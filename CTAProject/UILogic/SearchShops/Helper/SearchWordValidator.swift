//
//  SearchWordValidator.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/03/01.
//

import RxSwift

extension SearchShopsViewModel {
    class SearchWordValidator {
        enum ValidationResult {
            case valid(searchWord: String)
            case exceededWordCount

        }

        static func validate(_ searchWord: String) -> ValidationResult {
            if searchWord.count > 50 {
                return .exceededWordCount
            }
            return .valid(searchWord: searchWord)
        }
    }
}

extension ObservableType where Element == SearchShopsViewModel.SearchWordValidator.ValidationResult {
    func filterValid() -> Observable<String> {
        flatMap { element -> Observable<String> in
            switch element {
            case .valid(let searchWord):
                return .just(searchWord)
            default:
                return .empty()
            }
        }
    }

    func filterExceededWordCount() -> Observable<Bool> {
        flatMap { element -> Observable<Bool> in
            switch element {
            case .exceededWordCount:
                return .just(true)
            default:
                return .empty()
            }
        }
    }

}
