//
//  ApiProvider.swift
//  data
//
//  Created by Daniel Christopher on 2/9/20.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import domain
import Foundation
import Moya
import RxSwift

public enum ApiRequestError: Swift.Error {
    case failure(response: Response)
    case badRequest(response: Response)
    case notFound (response: Response)
    case notAuthenticated(response: Response)
    case conflict(response: Response)
    case networkFailure(response: Response)
}

public protocol BaseTargetType: TargetType {
    var requiresAuthToken: Bool { get }
}


protocol AuthTokenProvider {
    func provideToken() -> String?
}

class ApiProvider <T: BaseTargetType> {
    var provider: MoyaProvider<T>?
    
    private var accountDao: AccountDao? = nil
    
    func setAccountDao(_ accountDao: AccountDao) {
        self.accountDao = accountDao
    }
    
    func request(target: T) -> Observable<Response> {
        print(target)

        return provider!.rx.request(target)
            .asObservable()
            .flatMap({ response -> Observable<Response> in
                switch response.statusCode {
                case 200...299, 300...399:
                    self.handleNetworkSuccess(response: response)
                    break
                case 401:
                    // when the API is saying we are not authorized user will need to sign in again
                    // TODO implement auto token refresh
                    self.handleUnauthenticated(response: response)
                    return Observable.error(ApiRequestError.badRequest(response: response))
                case 400:
                    self.handleServerError(error: nil)
                    return Observable.error(ApiRequestError.badRequest(response: response))
                case 404:
                    self.handleServerError(error: nil)
                    return Observable.error(ApiRequestError.notFound(response: response))
                case 409:
                    self.handleServerError(error: nil)
                    return Observable.error(ApiRequestError.conflict(response: response))
                case 502:
                    self.handleServerError(error: nil)
                    return Observable.error(ApiRequestError.networkFailure(response: response))
                default:
                    self.handleServerError(error: nil)
                    return Observable.error(ApiRequestError.failure(response: response))
                }

                return Observable.just(response)
            })
            .do(onError: { error in
                self.handleServerError(error: error)
            })
    }
    
    func endpointClosure(target: BaseTargetType) -> Endpoint {
        let url = target.baseURL.appendingPathComponent(target.path)
        let sampleResponseClosure = { return EndpointSampleResponse.networkResponse(200, target.sampleData) }

        let endpoint = Endpoint(url: url.absoluteString, sampleResponseClosure: sampleResponseClosure, method: target.method, task: target.task, httpHeaderFields: target.headers)

        // Add content type http header to all requests
        var headers: [String: String] = target.headers ?? [:]

        // If the endpoint requires authentication, add JWT header
        if target.requiresAuthToken, let token = self.accountDao?.getAuthToken()?.accessToken {
            headers["Authorization"] = "Bearer \(token)"
            print(headers["Authorization"])
        }

        return endpoint.adding(newHTTPHeaderFields: headers)
    }
    
    private func handleNetworkSuccess(response: Response) {
         print(response)
     }

     private func handleNetworkFailure() {
         print("handleNetworkFailure")
     }

     private func handleServerError(error: Swift.Error?) {
         print(error)
     }

     private func handleUnauthenticated(response: Response) {
         print(response)
     }

}
