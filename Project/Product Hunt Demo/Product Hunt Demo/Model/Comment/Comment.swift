//
//  Comment.swift
//  Created by Pushpsen Airekar on 26/1/20.
//  Copyright © 2020 Pushpsen Airekar. All rights reserved.
//

// MARK: - Importing Frameworks.

import Foundation

/* ----------------------------------------------------------------------------------- */

class Comment {
    
    // MARK: - Declaration of Variables
    
    var uid: String
    var name: String
    var profession:String
    var avatar: String
    var comment: String
    var time: String
    
    // MARK: - Initialization
    
    init(uid: String, name: String, profession: String, avatar: String, comment: String, time: String) {
        self.uid = uid
        self.name = name
        self.profession = profession
        self.avatar = avatar
        self.comment = comment
        self.time = time
    }
}

/* ----------------------------------------------------------------------------------- */
