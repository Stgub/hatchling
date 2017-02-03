//
//  PostsManager.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/31/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import Foundation
import Firebase

class PostManager{
    static let pm = PostManager()
    private var _feedPosts:[Post] = []
    private var _currentPost:Post!
    private var imageCache: NSCache<NSString, UIImage> = NSCache()


    var currentPost:Post?{
        if _currentPost == nil {
            print("No current post")
        }
        return _currentPost
    }
    func adjustLikesForCurrentPost(addLike: Bool){
        _currentPost.adjustLikes(addLike: addLike)
    }
    func setImg(img: UIImage, forKey: NSString ){
         imageCache.setObject(img, forKey: forKey)
    }
    func submitUpdate(newUpdate:Update, withCompletionBlock: (_ error: NSError?) -> Void ){
        let updateData = newUpdate.createFirebaseUpdate()
        let firebasePost = DataService.ds.REF_UPDATES.childByAutoId()
        let postId = firebasePost.key
        DataService.ds.REF_USER_CURRENT.child(userDataTypes.posts).child(postId).setValue(true)
        firebasePost.setValue(updateData, withCompletionBlock: {
            (error, ref) in
            withCompletionBlock(error)
        })
    }
    /**
     Returns the upates for the likes a user has 
 */
    func getUsersLikesUpdates(withCompletionBlock:([Update]) -> Void ){
        var usersLikesUpdates:[Update] = []
        getUsersLikesKeys { (likesKeys) in
            DataService.ds.REF_UPDATES.observeSingleEvent(of: .value, with: { (snapshot) in
               if  let snapshots = snapshot.children.allObjects as [FIRDataSnapshot] {
                for snap in snapshots {
                    let updateKey = snap.key
                    if likesKeys.contains(updateKey) {
                        let updateDict = snap.value as! NSDictionary<String, AnyObject>
                        let update = Update(updateKey, updateData: updateDict)
                        usersLikesUpdates.append(update)
                    }
                }
                withCompletionBlock(usersLikesUpdates)
                }
            })
        }
    }
    /**
     Returns the keys for all of the likes a user has
 */
    func getUsersLikesKeys(withCompletionBlock:([String]) -> Void){
        var usersLikesKeys:[String] = []
        DataService.ds.REF_USER_CURRENT.child(userDataTypes.likes).observeSingleEvent(of: .value, with: {
            (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    let key = snap.key
                        usersLikesKeys.append(key)
                }
                withCompletionBlock(usersLikesKeys)
            }
        })
    }
    /**
     Gets the image requested. First it looksed in the local stored cache, if not there it downloads it from firebase and then saves it to local cache
     @param imgUrl - firebase url asscoiated with the img
     */
    func getImage(imgUrl:String, returnBlock: @escaping (_ img: UIImage)-> Void ){
        var returnImg:UIImage!
        if let img = self.imageCache.object(forKey: imgUrl as NSString) {
            returnImg = img
            returnBlock(returnImg)
        } else {
            let ref = FIRStorage.storage().reference(forURL: imgUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Chuck: Error downloading img -\(error)")
                    
                } else {
                    print("Chuck: Img downloaded from Firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            returnImg = img
                            self.setImg(img: img, forKey: imgUrl as NSString)
                            returnBlock(returnImg)
                        }
                    }
                }
            })
        }
    }
    /**
     General function to get a users posts, or a users liked posts
 */
    func getUsers(userDataType: String, returnBlock: @escaping (_ returnPosts:[Post]) -> Void){
        var returnedKeys:[String] = []
        DataService.ds.REF_USER_CURRENT.child(userDataType).observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    //print("SNAP: \(snap)")
                    let key = snap.key
                    returnedKeys.append(key)
                    
                }
                self.loadPosts(keys: returnedKeys, returnBlock: {
                    (returnedPosts) in
                    returnBlock(returnedPosts)
                })
            }
        })
    }

    func loadPosts(keys:[String], returnBlock:@escaping (_ returnedPosts:[Post]) -> Void){
        var returnedPosts:[Post] = []
            DataService.ds.REF_POSTS.observeSingleEvent(of: .value, with: {
                (snapshot) in
                if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    for snap in snapshots {
                        //print("Posts SNAP - \(snap)")
                        let key = snap.key
                        if keys.contains(snap.key){
                            if let postData = snap.value as? Dictionary<String, AnyObject>{
                                let post = Post(postKey: key, postData: postData)
                                returnedPosts.append(post)
                            }
                            
                        }
                    }
                    returnBlock(returnedPosts)
                }
            }
            )
        
    }
    /**
     Gets the current posts fromt the database
     @param: The function to run once posts have been added, can take no input
     */
    func getPosts(returnBlock:   @escaping (  ) -> Void ){
        DataService.ds.REF_POSTS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                print("Chuck: got snapshots of posts")
                for snap in snapshots {
                    print("SNAP: \(snap)")
    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self._feedPosts.append(post)
                    }
                }
                print("Chuck: after snap for loop")
                returnBlock() // executes the input function

            }
        })
    }

    
    func nextPost() -> Post?{
        if let _ = _currentPost {
            _feedPosts.removeFirst()
        }
        
        if  _feedPosts.count > 0 {
            _currentPost = _feedPosts.first
        } else {
            _currentPost = nil
        }
        return _currentPost
        
    }
}
