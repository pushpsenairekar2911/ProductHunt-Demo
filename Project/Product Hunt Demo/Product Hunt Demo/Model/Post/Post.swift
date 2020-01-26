//
//  Post.swift
//  Created by Pushpsen Airekar on 26/1/20.
//  Copyright © 2020 Pushpsen Airekar. All rights reserved.
//

// MARK: - Importing Frameworks.

import Foundation

/* ----------------------------------------------------------------------------------- */

class Post {
    
    // MARK: - Declaration of Variables
    
    var uid: String
    var pid: String
    var title: String
    var message: String
    var count: Int
    var imageURL: String
    
    // MARK: - Initialization
    
    init(uid:String, pid: String, title: String, message:String, count: Int, imageURL: String){
        self.uid = uid
        self.pid = pid
        self.title = title
        self.message = message
        self.count = count
        self.imageURL = imageURL
    }
}

/* ----------------------------------------------------------------------------------- */
