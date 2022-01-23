//
//  APIClient.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/20
//

import Foundation
import Moya
import RxSwift


protocol APIClientProtocol {
    func send<Request: BaseTargetType>(provider: MoyaProvider<MultiTarget>, _ request: Request) -> Observable<APIResult<Request.Response, Request.ErrorResponse>>
}

final class APIClient: APIClientProtocol {
    static let shared = APIClient()
    private let provider = MoyaProvider<MultiTarget>()
    private let decoder: JSONDecoder = {
    let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func send<Request: BaseTargetType>(provider: MoyaProvider<MultiTarget> = MoyaProvider<MultiTarget>(),_ request: Request) -> Observable<APIResult<Request.Response, Request.ErrorResponse>> {
        Observable.create { [self] observer in
            return provider.rx.request(MultiTarget(request))
                .filterSuccessfulStatusCodes()
                .map(Request.Response.self, using: self.decoder)
                .subscribe { event in
                    switch event {
                    case .success(let response):
                        observer.onNext(.success(response))
                    case .failure(let error):
                        if let moyaError = error as? MoyaError {
                            switch moyaError {
                            case .statusCode(let response):
                                do {
                                    let errorResponse = try self.decoder.decode(Request.ErrorResponse.self, from: response.data)
                                    observer.onNext(.error(errorResponse))
                                } catch {
                                    observer.onError(error)
                                }
                            default:
                                observer.onError(error)
                            }
                        }
                    }
                }
        }
    }
}

