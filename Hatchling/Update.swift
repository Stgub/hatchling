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
    func setUpdateType(type: String){self._updateType = type}
    
    
    var _prodName:String!
    var prodName:String? { return _prodName }
    
    var _link:String!
    var link:String? { return _link }
    func setLink(link:String){ self._link = link }
    
    var _description:String!
    var description:String? {return _description }
    func setDescription(descript: String){ self._description = descript }
    
    var _prodLogoUrl:String!
    var prodLogoUrl:String? {return _prodLogoUrl}
    func setProdLogoUrl(url: String) { self._prodLogoUrl = url }
    //Intialization used when loading an update
    init(updateKey: String, updateData: Dictionary<String, AnyObject>){
        self._updateKey = updateKey
        
        if let prodKey =  updateData[updateDataTypes.prodKey] as? String{
            self._prodKey = prodKey
        }
        if let prodName = updateData[updateDataTypes.prodName] as? String{
            self._prodName = prodName
        }
        if let updateType = updateData[updateDataTypes.updateType] as? String{
            self._updateType = updateType
        }
        if let descript = updateData[updateDataTypes.description] as? String{
            self._description = descript
        }
        if let link = updateData[updateDataTypes.link] as? String {
            self._link = link
        }
        if let prodLogoUrl = updateData[updateDataTypes.prodLogoUrl] as? String {
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
    
        var updateDict: Dictionary<String,AnyObject> = [
            updateDataTypes.prodName : self._prodName as AnyObject,
            updateDataTypes.updateType : self._updateType as AnyObject,
            updateDataTypes.description : self._description as AnyObject,
            updateDataTypes.prodKey : self._prodKey as AnyObject,
            updateDataTypes.prodLogoUrl: self._prodLogoUrl as AnyObject
        ]
        if let link = self._link {
           updateDict[updateDataTypes.link] = link as? AnyObject
        }
        
        
        return updateDict
        
    }
}
