//
//  AuthToken.swift
//  domain
//
//  Created by Daniel Christopher on 2/9/20.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import Foundation

public struct AuthToken {
    public var accessToken: String?
    public var expiresIn: Int
    public var refreshExpiresIn: Int
    public var refreshToken: String?
    public var tokenType: String?
    public var idToken: String?
    public var sessionState: String?
    public var scope: String?
    
    public init() {
        accessToken = nil
        expiresIn = 0
        refreshExpiresIn = 0
        refreshToken = nil
        tokenType = nil
        idToken = nil
        sessionState = nil
        scope = nil
    }
}
