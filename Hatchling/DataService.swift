//
//  DataService.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/15/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

struct userDataTypes {
    static let email = "email"
    static let name = "name"
    static let gender = "gender"
    static let provider = "provider"
    static let birthday = "birthday"
    
}
var userImage:UIImage! //SHOULDNT BE HERE JUST TEMPORARY


let DB_BASE = FIRDatabase.database().reference() // gives the URL of the root of the db, also in the google plist
let STORAGE_BASE = FIRStorage.storage().reference()
private var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics")

class DataService {
    static let ds = DataService() //Singleton
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    //make private varibales globally accessible
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    var REF_USER_CURRENT: FIRDatabaseReference {
        //let uid = KeychainWrapper.stringForKey(KEY_UID)
        //let uid = KeychainWrapper.set(KEY_UID)
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user

    }
    
    var REF_POST_IMAGES: FIRStorageReference {
        return _REF_POST_IMAGES
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String> ){
        REF_USERS.child(uid).updateChildValues(userData) //will not wipe out a value that is already there.. set value will
        }
    
    
    
}
