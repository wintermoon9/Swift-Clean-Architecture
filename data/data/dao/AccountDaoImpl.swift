//
//  AccountDao.swift
//  data
//
//  Created by Daniel Christopher on 2/9/20.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import domain
import Foundation
import KeychainAccess


class AccountDaoImpl: AccountDao {
    private let KEY_AUTH_TOKEN = "token"

    private let keychain: Keychain

    init (keychain: Keychain) {
        self.keychain = keychain
    }

    func getAuthToken() -> AuthToken? {
        do {
            if let json = try keychain.get(KEY_AUTH_TOKEN) {
                return AuthToken(JSONString: json)
            }
        } catch {
            print(error)
            return nil
        }

        return nil
    }

    func saveAuthToken (_ token: AuthToken) {
        keychain[KEY_AUTH_TOKEN] = token.toJSONString()
    }
}
