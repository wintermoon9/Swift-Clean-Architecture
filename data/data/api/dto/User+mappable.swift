//
//  User+mappable.swift
//  data
//
//  Created by Daniel Christopher on 2/9/20.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import domain
import Foundation
import ObjectMapper

extension User: Mappable {
    
    public init?(map: Map) {
        self.init()
    }
    
    public mutating func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
    }
}
