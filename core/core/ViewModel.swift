//
//  ViewModel.swift
//  core
//
//  Created by Daniel Christopher on 2/9/20.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import Foundation

public protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
