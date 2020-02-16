//
//  SearchViewModel.swift
//  feature
//
//  Created by Daniel Christopher on 2/9/20.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import core
import domain
import Foundation
import RxCocoa
import RxSwift

class SearchViewModel: ViewModel {
    
    private let userRepository: UserRepository
    
    public init (userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func transform(input: SearchViewModel.Input) -> SearchViewModel.Output {
        let users = input.searchUsers.flatMap { [weak self] query -> Driver<Resource<[User]>> in
            guard let `self` = self else {
                return Driver.never()
            }
            
            return self.userRepository.searchUsers(query: query)
                .asResourceDriver()
                .startWith(.loading)
        }
        
        return Output(users: users)
    }
    
    struct Input {
        var searchUsers: Driver<String>
    }
    
    struct Output {
        var users: Driver<Resource<[User]>>
    }
}
