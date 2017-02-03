//
//  Update.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/2/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import Foundation
struct updateDataTypes {
    static let prodName = "prodName"
    static let updateType = "updateType"
    static let link = "link"
    static let description = "description"
    static let prodKey = "prodKey" //post id or product id related to post
    static let prodLogo = "prodLogo"
    static let prodLogoUrl = "prodLogoUrl"
}
class Update{
    var _updateKey:String!
    var updateKey:String{ return _updateKey }
    var _prodKey:String!
    var prodKey:String { return _prodKey }
    var _updateType:String!
    var updateType:String { return _updateType }
    var _prodName:String!
    var prodName:String { return _prodName }
    var _link:String!
    var prodName:String { return _prodName }
    var _description:String!
    var description:String {return _description }
    var _prodLogoUrl:String!
    var prodLogoUrl:String? {return _prodLogoUrl}
    
    //Intialization used when loading an update
    init(updateKey: String, updateData:NSDictionary<String,AnyObject>){
        self._updateKey = updateKey
        
        if let prodKey =  updateData[updateDataTypes.prodKey] as! String{
            self._prodKey = prodKey
        }
        if let prodName = updateData[updateDataTypes.prodName] as! String{
            self.prodName = prodName
        }
        if let updateType = updateData[updateDataTypes.updateType] as! String{
            self._updateType = updateType
        }
        if let descript = updateData[updateDataTypes.description] as! String{
            self._description = descript
        }
        if let link = updateData[updateDataTypes.link] as! String {
            self._link = link
        }
        if let prodLogoUrl = updateData[updateDataTypes.prodLogoUrl] as! String {
            self._prodLogoUrl = prodLogoUrl
        }
    }
    //Intialization used when creating an update
    init(forPost: Post){
        self._prodKey = forPost.postKey
        self._prodName = forPost.name
        self._prodLogoUrl = forPost.logoUrl
    }
    func createFirebaseUpdate()->Dictionary<String,AnyObject>{
        let updateDict: Dictionary<String,AnyObject> = [
            updateDataTypes.name : self._name as AnyObject,
            updateDataTypes.updateType : self._updateType as AnyObject,
            updateDataTypes.description : self._description as AnyObject,
            updateDataTypes.link : self._link as AnyObject,
            updateDataTypes.prodKey : self._prodKey as AnyObject,
            updateDataTypes.prodLogoUrl: self._prodLogoUrl as AnyObject
        ]
        
        
        return updateDict
        
    }
}
