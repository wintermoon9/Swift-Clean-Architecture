//
//  UserRepositoryImpl.swift
//  data
//
//  Created by Daniel Christopher on 2/9/20.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import domain
import Foundation
import RxSwift
import Moya_ObjectMapper

public class UserRepositoryImpl: UserRepository {
    
    private var api: ApiProvider<SearchApi>
    
    init (api: ApiProvider<SearchApi>) {
        self.api = api
    }
    
    public func searchUsers(query: String) -> Single<[User]> {
        return api.request(target: .search(query: query))
            .mapArray(User.self)
            .asSingle()
    }
}
