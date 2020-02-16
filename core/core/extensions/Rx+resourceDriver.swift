//
//  Driver+resource.swift
//  Juna
//
//  Created by Daniel Christopher on 31/10/19.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import domain
import Foundation
import RxSwift
import RxCocoa

public enum ApiRequestError: Swift.Error {
    case failure
    case badRequest
    case notFound
    case notAuthenticated
    case conflict
    case networkFailure
}

private func mapErrorToResource <T: Any> (error: Error) -> Resource<T> {
    switch (error) {
    case ApiRequestError.badRequest,
         ApiRequestError.conflict,
         ApiRequestError.failure:
        return Resource<T>.error(code: .internalError)
    case ApiRequestError.networkFailure:
        return Resource<T>.error(code: .networkFailure)
    case ApiRequestError.notAuthenticated:
        return Resource<T>.error(code: .notAuthorized)
    default:
        return Resource<T>.error(code: .internalError)
    }
}

extension Observable where Element: Any {
    
    public func asResourceDriver() -> Driver<Resource<Element>> {
        return map { Resource.success(data: $0) }
            .asDriver { error -> Driver<Resource<Element>> in
                return Driver.just(mapErrorToResource(error: error))
            }
    }
}

public extension PrimitiveSequenceType where Trait == SingleTrait {
    
    public func asResourceDriver() -> Driver<Resource<Element>> {
        return map { Resource.success(data: $0) }
            .asDriver { error -> Driver<Resource<Element>> in
                return Driver.just(mapErrorToResource(error: error))
            }.startWith(.loading)
    }
}
