//
//  Account.swift
//  Grovechaos
//
//  Created by Hayne Park on 11/21/17.
//  Copyright © 2017 Alexander Bui. All rights reserved.
//

import Foundation

class Account: NSObject {
    var name: String
    var number: String
    var image: String?
    var location: String
    
    init(name: String, number: String, image: String?, location: String) {
        self.name = name
        self.number = number
        self.image = image
        self.location = location
    }
}
