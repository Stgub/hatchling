//
//  Comment.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/7/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import Foundation

class Comment{
    private var _creatorKey:String!
    private var _content:String!
    private var _creatorUserName:String!
    
    init(content:String){
        self._content = content
        self._creatorUserName = currentUser.name
        self._creatorKey = currentUser.key
    }
    
    
    
}
