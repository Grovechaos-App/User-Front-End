//
//  Post.swift
//  Grovechaos
//
//  Created by Hayne Park on 11/20/17.
//  Copyright © 2017 Alexander Bui. All rights reserved.
//

import Foundation

class Post: NSObject {
    var name: String
    var imageUrl: String?
    var owner: Account
    
    init(name: String, imageUrl: String?, owner: Account) {
        self.name = name
        self.imageUrl = imageUrl
        self.owner = owner
    }
}
