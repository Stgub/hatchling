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
    static let caption = "caption"
    static let likes = "likes"
    static let imgUrl = "imgUrl"
    static let name = "name"
    static let stage = "stage"
}
class Post {
    private var _name: String!
    private var _caption: String!
    private var _imageUrl: String!
    private var _likes: Int!
    private var _postKey: String!
    private var _postRef: FIRDatabaseReference!
    private var _stage:String!

    var caption :String {
        return _caption
    }
    var imageUrl:String {
        return _imageUrl
    }
    var likes: Int {
        return _likes
    }
    var postKey:String {
        return _postKey
    }
    var name:String {
        return _name
    }
    var stage:String {
        return _stage
    }

    init(caption:String , imageUrl: String , likes: Int){
        self._caption = caption
        self._imageUrl = imageUrl
        self._likes = likes
    }
    init( postKey: String , postData: Dictionary<String, AnyObject> ){
        self._postKey = postKey
        if let caption = postData[postDataTypes.caption] as? String {
            self._caption = caption
        }
        if let likes = postData[postDataTypes.likes] as? Int{
            self._likes = Int(likes)
        }
        if let imageUrl = postData[postDataTypes.imgUrl] as? String{
            self._imageUrl = imageUrl
        }
        if let name = postData[postDataTypes.name] as? String {
            self._name = name
        }
        if let stage = postData[postDataTypes.stage] as? String {
            self._stage = stage
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
