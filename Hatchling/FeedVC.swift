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
        
        //Downloads posts data and sets and observer for if anything chanages
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                        self.nextPost()
                    }
                } 
                
            }
            
        })        // Do any additional setup after loading the view.
    }
    var index = 0
    func previousPost(){
        if index - 1 > 0 {
            index -= 1
            let post = posts[index]
            showPost(post: post)
        }
    }
    func nextPost(){
        if index + 1 < posts.count {
            index += 1
            let post = posts[index]
            showPost(post:post)
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
    func configurePost(post: Post, img: UIImage? = nil) {
        // TEMPORARY
        if let usrImg = userImage {
            posterImage.image = usrImg
        }
        
         self.postCaption.text = post.shortDescript
    //   self.postLikes.text = "\(post.likes)"
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
        //single event just checks once if it has been liked instead of constant observation
        currentUserLikesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                print("post not liked")
                //self.postLikes.image = UIImage(named: "empty-heart")
            } else {
                print("post liked")
                //self.postLikes.image = UIImage(named: "filled-heart")
            }
        })
    }
    


    @IBAction func likeTapped(_ sender: Any) {
        print("Like button tapped")
        currentUserLikesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                //self.likeImg.image = UIImage(named: "filled-heart")
                self.currentPost.adjustLikes(addLike: true)
                self.currentUserLikesRef.child(self.currentPost.postKey).setValue(true)
                
                
            } else {
                //self.likeImg.image = UIImage(named: "empty-heart")
                self.currentPost.adjustLikes(addLike: false)
                self.currentUserLikesRef.child(self.currentPost.postKey).removeValue()
            }
        })
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
                print("left drag - next profile")
                self.nextPost()
            } else if view.center.x > self.view.bounds.width - 100 {
                print("right drag - previous profile")
                self.previousPost()
            }
            //Returns the view back to normal
            rotation = CGAffineTransform(rotationAngle: 0)
            stretch = rotation.scaledBy(x: 1, y: 1)
            view.transform = stretch
            view.center  = originalCenter
        }
    }


}
