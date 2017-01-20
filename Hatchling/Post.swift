//
//  Post.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/15/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import Foundation
import Firebase


//Strings for accessing firebase data
struct postDataTypes{
    static let shortDescript = "shortDescription"
    static let longDescript = "longDescript"
    static let likes = "likes"
    static let name = "name"
    static let logoUrl = "imgUrl"
    static let productUrl = "productUrl"
    static let logoImg = "logoImg"
    static let productImg = "productImg"
    static let prodStage = "prodStage"
    static let prodCategories = "prodCategories"
    static let prodTalent = "prodTalent"
}
class Post {
    private var _name: String!
    private var _shortDescript: String!
    private var _longDescript:String!
    private var _likes: Int!
    private var _postKey: String!
    private var _postRef: FIRDatabaseReference!
    private var _productUrl: String!
    private var _logoUrl: String!
    
    private var _prodStage:String!
    private var _prodCategories:String!
    private var _prodTalent:String!
    
    private var _productImg:UIImage!
    private var _logoImg:UIImage!
    
    var shortDescript :String { return _shortDescript }
    var longDescript:String { return _longDescript }

    var likes: Int {
        return _likes
    }
    var postKey:String {
        return _postKey
    }
    var name:String {
        return _name
    }
    var productUrl:String{
        return _productUrl
    }
    var logoUrl:String{
        return _logoUrl
    }
    var productImg:UIImage {
        return _productImg
    }
    var logoImg:UIImage { return _logoImg }
    var prodStage:String {return _prodStage}
    var prodCategories:String { return _prodCategories }
    var prodTalent:String { return _prodTalent }
    init(){
    }
    init(shortDescript:String , imageUrl: String , likes: Int){
        self._shortDescript = shortDescript
        self._productImg = productImg
        self._likes = likes
    }
    init( postKey: String , postData: Dictionary<String, AnyObject> ){
        self._postKey = postKey
        
        if let shortDescript = postData[postDataTypes.shortDescript] as? String{
            self._shortDescript = shortDescript
        }
        if let longDescript = postData[postDataTypes.longDescript] as? String {
            self._longDescript = longDescript
        }
        if let likes = postData[postDataTypes.likes] as? Int{
            self._likes = Int(likes)
        }
        if let productUrl = postData[postDataTypes.productUrl] as? String{
            self._productUrl = productUrl
        }
        if let logoUrl = postData[postDataTypes.logoUrl] as? String{
            self._logoUrl = logoUrl
        }
        if let name = postData[postDataTypes.name] as? String {
            self._name = name
        }
        if let prodStage = postData[postDataTypes.prodStage] as? String {
            self._prodStage = prodStage
        }
        if let prodCategories = postData[postDataTypes.prodCategories] as? String {
            self._prodCategories = prodCategories
        }
        
        _postRef = DataService.ds.REF_POSTS.child(_postKey)

    }
    
    func adjustLikes(addLike: Bool) {
        if addLike {
            _likes = _likes + 1
        } else {
            _likes = likes - 1
        }
        _postRef.child(postDataTypes.likes).setValue(_likes)
        
    }
}
