//
//  UserRepository.swift
//  domain
//
//  Created by Daniel Christopher on 2/9/20.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import Foundation
import RxSwift

public protocol UserRepository {
    func searchUsers(query: String) -> Single<[User]>
}
