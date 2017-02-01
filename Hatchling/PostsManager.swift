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
        return _currentPost
    }
    func adjustLikesForCurrentPost(addLike: Bool){
        _currentPost.adjustLikes(addLike: addLike)
    }
    func setImg(img: UIImage, forKey: NSString ){
         imageCache.setObject(img, forKey: forKey)

    }
    func getPostImg(imgUrl: String) -> UIImage? {
        let img = imageCache.object(forKey: imgUrl as NSString)
        return img
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
