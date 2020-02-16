//
//  UIApplication+di.swift
//  core
//
//  Created by Daniel Christopher on 2/9/20.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import Foundation
import Swinject
import UIKit

extension UIApplication {
    
    public static func container() -> Resolver {
        return plankDelegate().assembler.resolver
    }
    
    public static func plankDelegate() -> PlankAppDelegate {
        return (UIApplication.shared.delegate as! PlankAppDelegate)
    }
}
