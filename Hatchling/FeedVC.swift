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
    var likesRef: FIRDatabaseReference! // used  for updating likes when tapped
    var currentPost:Post!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()

     var posts:[Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalCenter = swipeCardView.center
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(FeedVC.wasDragged(_:)))
        swipeCardView.addGestureRecognizer(swipeGesture)
        //Downloads posts data and sets and observer for if anything chanages
        //DataService.ds.REF_POSTS.
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
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
            //RELOAD DATA i.e. self.tableview.reloadData()
            
        })        // Do any additional setup after loading the view.
    }

    func previousPost(){
        if posts.count > 0 {
            let post = posts[0]
            showPost(post: post)
        }
    }
    func nextPost(){
        if posts.count < 1 {
            let post = posts[1]
            showPost(post:post)
        }

    }
    func showPost(post:Post){
        currentPost = post
        if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
            self.configurePost(post: post, img: img)
        } else {
            self.configurePost(post: post)
        }
        
    }
    func configurePost(post: Post, img: UIImage? = nil) {
         likesRef = DataService.ds.REF_USER_CURRENT.child("likes").child(post.postKey)
        
         self.postCaption.text = post.caption
         self.postLikes.text = "\(post.likes)"
         self.posterName.text = post.name
        
        if img != nil {
            self.postImage.image = img
        } else {
            let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Chuck: Unable to download image from Firebase storage")
                } else {
                    print("Chuck: Image downloaded from Firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImage.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                        }
                    }
                }
            })
        }
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
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
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                //self.likeImg.image = UIImage(named: "filled-heart")
                self.currentPost.adjustLikes(addLike: true)
                self.likesRef.setValue(true)
            } else {
                //self.likeImg.image = UIImage(named: "empty-heart")
                self.currentPost.adjustLikes(addLike: false)
                self.likesRef.removeValue()
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
