//
//  Resource.swift
//  domain
//
//  Created by Daniel Christopher on 31/10/19.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import Foundation

public enum Resource<T> {
    case success (data: T)
    case error (code: ResourceError)
    case loading
}

public enum ResourceError {
    case networkFailure
    case internalError
    case notFound
    case notAuthorized
}
