//
//  SearchApi.swift
//  data
//
//  Created by Daniel Christopher on 2/9/20.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import core
import domain
import Foundation
import Moya
import ObjectMapper
import RxSwift

public enum SearchApi {
    case search (query: String)
}

extension SearchApi: BaseTargetType {
    public var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }

    public var baseURL: URL { return URL(string: Api.SEARCH_API_URL)! }

    public var path: String {
        switch self {
        default: return "/"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        default: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        default: return .requestPlain
        }
    }
    
    public var requiresAuthToken: Bool {
        switch self {
        default:
            return true
        }
    }
    
    public var encoding: ParameterEncoding {
         if self.method == .get || self.method == .head {
             return URLEncoding.default
         }
         else {
             return JSONEncoding.default
         }
     }
}
