//
//  RepositoryAssembly.swift
//  data
//
//  Created by Daniel Christopher on 2/9/20.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import domain
import Foundation
import KeychainAccess
import Swinject

class RepositoryAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(Keychain.self) { r in
            Keychain()
        }
        
        container.register(AccountDao.self) { r in
            AccountDaoImpl(keychain: r.resolve(Keychain.self)!)
        }
        
        container.register(UserRepository.self) { r in
            UserRepositoryImpl(api: r.resolve(ApiProvider<SearchApi>.self)!)
        }
    }
}
