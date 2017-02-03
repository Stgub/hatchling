//
//  Update.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/2/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import Foundation
struct updateDataTypes {
    static let name = "name"
    static let updateType = "updateType"
    static let link = "link"
    static let description = "description"
    static let prodName = "prodName"
    static let prodKey = "prodKey" //post id or product id related to post
    static let prodLogo = "prodLogo"
}

class Update{
    var prodKey:String!
    var updateType:String!
    var name:String!
    var prodName: String!
    var link:String!
    var description:String!
    var prodLogo:String!
    
    init(forPost: Post){
        self.prodKey = forPost.postKey
        self.prodName = forPost.name
    }
    func createFirebaseUpdate()->Dictionary<String,AnyObject>{
        let updateDict: Dictionary<String,AnyObject> = [
            updateDataTypes.prodName   : self.prodName as AnyObject,
            updateDataTypes.updateType : self.updateType as AnyObject,
            updateDataTypes.description : self.description as AnyObject,
            updateDataTypes.link : self.link as AnyObject,
            updateDataTypes.prodKey : self.prodKey as AnyObject
        ]
        
        
        return updateDict
        
    }
}
