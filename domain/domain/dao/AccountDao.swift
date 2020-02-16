//
//  AccountDao.swift
//  domain
//
//  Created by Daniel Christopher on 2/9/20.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import Foundation

public protocol AccountDao {
    func getAuthToken() -> AuthToken?
    func saveAuthToken (_ token: AuthToken)
}
