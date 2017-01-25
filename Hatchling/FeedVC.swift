//
//  FeedVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/14/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var posterImage: RoundPic!
    @IBOutlet weak var posterName: UILabel!
    @IBOutlet weak var postStage: UILabel!
    @IBOutlet weak var postLikes: UILabel!
    @IBOutlet weak var postCaption: UILabel!
    
    
    @IBOutlet weak var swipeCardView: swipeCardShadowRoundCorner!
    var originalCenter:CGPoint! //used for swiping to return to the original position
    var currentUserLikesRef:FIRDatabaseReference!
    var likesRef: FIRDatabaseReference! // used  for updating likes when tapped
    var currentPost:Post!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()

     var posts:[Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //Used to access the users likes
        currentUserLikesRef = DataService.ds.REF_USER_CURRENT.child("likes")

        // TEMPORARY

        if let usrImg = userImage {
            posterImage.image = usrImg
        }
        //Swipe gesture stuff
        originalCenter = swipeCardView.center
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(FeedVC.wasDragged(_:)))
        swipeCardView.addGestureRecognizer(swipeGesture)
        
        //Downloads posts data

        DataService.ds.REF_POSTS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.nextPost() // show first post
        })
    }
    
    private var postIndex = 0

    func nextPost(){
        if postIndex + 1 < posts.count {
            postIndex += 1
            let post = posts[postIndex]
            showPost(post:post)
        } else {
            print("No more posts to show")
        }

    }
    func showPost(post:Post){
        currentPost = post
        if let img = FeedVC.imageCache.object(forKey: post.productUrl as NSString) {
            self.configurePost(post: post, img: img)
        } else {
            self.configurePost(post: post)
        }
        
    }
    func postWasSwiped(post: Post, wasLiked: Bool){
        post.adjustLikes(addLike: wasLiked)
        DataService.ds.REF_USER_CURRENT.child(userDataTypes.likes).child(post.postKey).setValue(true)        
        nextPost()
    }
    func configurePost(post: Post, img: UIImage? = nil) {
        // TEMPORARY
        if let usrImg = userImage {
            posterImage.image = usrImg
        }
      
         self.postCaption.text = post.shortDescript
         self.posterName.text = post.name
        
        if img != nil {
            self.postImage.image = img
        } else {
            let ref = FIRStorage.storage().reference(forURL: post.productUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Chuck: Unable to download image from Firebase storage")
                } else {
                    print("Chuck: Image downloaded from Firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImage.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.productUrl as NSString)
                        }
                    }
                }
            })
        }
    }
    
 

    @IBAction func signOutBtnTapped(_ sender: Any) {
       
        try! FIRAuth.auth()!.signOut()
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)

        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "intialVC") 
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    
    
    
    //MARK: - Gestures
    func wasDragged(_ gesture: UIPanGestureRecognizer)
    {
        let translation = gesture.translation(in: self.view)
        let view = gesture.view!
        //print("\(view.subviews.first?.frame)")
        view.center = CGPoint(x: swipeCardView.center.x + translation.x, y: self.swipeCardView.center.y + translation.y) // relative to bottom left of screen
        let xFromCenter = view.center.x - self.view.bounds.width/2
        let scale = 1000 / (abs(xFromCenter) + 1000 )
        var rotation = CGAffineTransform(rotationAngle: 0)
        var stretch = rotation.scaledBy(x: scale, y: scale)
        view.transform = stretch
        //Below decides if it is a left or right drag
        if gesture.state == UIGestureRecognizerState.ended {
            if view.center.x < 100 {
                print("left drag")
                self.postWasSwiped(post: currentPost, wasLiked: false)
            } else if view.center.x > self.view.bounds.width - 100 {
                print("right drag")
                self.postWasSwiped(post: currentPost, wasLiked: true)
            }
            //Returns the view back to normal
            rotation = CGAffineTransform(rotationAngle: 0)
            stretch = rotation.scaledBy(x: 1, y: 1)
            view.transform = stretch
            view.center  = originalCenter
        }
    }


}
