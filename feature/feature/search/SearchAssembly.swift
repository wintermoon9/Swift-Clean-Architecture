//
//  SearchAssembly.swift
//  feature
//
//  Created by Daniel Christopher on 2/9/20.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import domain
import Foundation
import Swinject

public class SearchAssembly: Assembly {
    
    public init() {
    }
    
    public func assemble(container: Container) {
        container.register(SearchViewModel.self) { r in
            SearchViewModel(userRepository: r.resolve(UserRepository.self)!)
        }
        
        container.register(SearchViewController.self) { r in
            SearchViewController(r.resolve(SearchViewModel.self)!)
        }
    }
}
