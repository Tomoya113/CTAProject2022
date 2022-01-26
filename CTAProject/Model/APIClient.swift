//
//  APIClient.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/20
//

import Foundation
import Moya
import RxSwift

/// @mockable
protocol APIClientProtocol {
    func send<Request: BaseTargetType>(provider: MoyaProvider<MultiTarget>, _ request: Request) -> Single<APIResult<Request.Response, Request.ErrorResponse>>
}

final class APIClient: APIClientProtocol {
    static let shared = APIClient()
    private let provider = MoyaProvider<MultiTarget>()
    
    func send<Request: BaseTargetType>(provider: MoyaProvider<MultiTarget> = MoyaProvider<MultiTarget>(),_ request: Request) -> Single<APIResult<Request.Response, Request.ErrorResponse>> {
        return provider.rx.request(MultiTarget(request))
            .flatMap { (result) -> Single<APIResult<Request.Response, Request.ErrorResponse>> in
                guard (200...299).contains(result.statusCode) else {
                    do {
                        let apiError = try result.map(Request.ErrorResponse.self)
                        return .just(.apiError(apiError))
                    } catch {
                        return .error(UnexpectedError())
                    }
                }
                do {
                    let response = try result.map(Request.Response.self, using: APIClient.decoder)
                    return .just(.success(response))
                } catch {
                    return .error(UnexpectedError())
                }
            }
    }
}


extension APIClient {
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
