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

//Global Variables
var currentUser:User!

class FeedVC: UIViewController {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var posterImage: RoundPic!
    @IBOutlet weak var posterName: UILabel!
    @IBOutlet weak var postStage: UILabel!
    @IBOutlet weak var postLikes: UILabel!
    @IBOutlet weak var postCaption: UILabel!
    @IBOutlet weak var postLogo: RoundPic!
    
    @IBOutlet weak var swipeCardView: swipeCardShadowRoundCorner!
    var originalCenter:CGPoint! //used for swiping to return to the original position



    override func viewDidLoad() {
        super.viewDidLoad()

   
        if PostManager.pm.currentPost == nil {
            swipeCardView.isHidden = true 
        }
        //Swipe gesture stuff
        originalCenter = swipeCardView.frame.origin
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(FeedVC.wasDragged(_:)))
        swipeCardView.addGestureRecognizer(swipeGesture)
        
        //Get users info 
        DataService.ds.REF_USER_CURRENT.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    if let userDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key //What kind of key is this?
                        let user = User(userKey: key , userData: userDict)
                        currentUser = user
                        
                    }
                }
            }
        })
        
        self.updateData()
    }
    
    
    func updateData(){
        print("CHUCK: Updating data for feedVC")
        //Downloads posts data then runs function when done
        PostManager.pm.getPosts(){
            //function to run when done
            self.nextPost()
        }
    }
    
    func nextPost() -> Void{
        print("next post")
    
        if let post = PostManager.pm.nextPost(){
            showPost(post: post)
        } else {
            print("No posts to show")
            swipeCardView.isHidden = true
        }
    }

    func showPost(post:Post){
        self.swipeCardView.isHidden = false
        configurePost(post: post)
        
    }
    func postWasSwiped( wasLiked: Bool){
        PostManager.pm.adjustLikesForCurrentPost(addLike: wasLiked)
        nextPost()
    }
    
    func configurePost(post: Post, img: UIImage? = nil) {

      
        self.postCaption.text = post.shortDescript
        self.postTitle.text = post.name
        //self.postStage.text = post.prodStage
    
        if let creatorName = post.creatorName {
            self.posterName.text = creatorName
        }
        
        PostManager.pm.getImage(imgUrl:post.productUrl){
            (img) in
            self.postImage.image = img
        }
        PostManager.pm.getImage(imgUrl: post.logoUrl){
            (img) in
            self.postLogo.image = img
        }
     
        
        if let logoImg = post.logoImg {
            self.postImage.image = logoImg
        } else {
            let logoUrl = post.logoUrl
            let ref = FIRStorage.storage().reference(forURL: logoUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Chuck: Error downloading logo img -\(error)")
                    
                } else {
                    print("Chuck: Logo Img downloaded from Firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postLogo.image = img
                            PostManager.pm.setImg(img: img, forKey: logoUrl as NSString)
                        }
                    }
                }
            })
        }

        if img != nil {
            self.postImage.image = img
        } else {
            let ref = FIRStorage.storage().reference(forURL: post.productUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Chuck: Error downloading product img -\(error)")
                } else {
                    print("Chuck: Product Img downloaded from Firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImage.image = img
                            PostManager.pm.setImg(img: img, forKey: post.productUrl as NSString)
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
        
        view.frame.origin = CGPoint(x: originalCenter.x + translation.x, y: self.originalCenter.y + translation.y) // relative to bottom left of screen
        let xFromCenter = view.center.x - self.view.bounds.width/2
        let scale = 1000 / (abs(xFromCenter) + 1000 )
        var rotation = CGAffineTransform(rotationAngle: 0)
        var stretch = rotation.scaledBy(x: scale, y: scale)
        view.transform = stretch
        //Below decides if it is a left or right drag
        if gesture.state == UIGestureRecognizerState.ended {
            if view.center.x < 100 {
                print("left drag")
                self.postWasSwiped( wasLiked: false)
            } else if view.center.x > self.view.bounds.width - 100 {
                print("right drag")
                self.postWasSwiped( wasLiked: true)
            }
            //Returns the view back to normal
            rotation = CGAffineTransform(rotationAngle: 0)
            stretch = rotation.scaledBy(x: 1, y: 1)
            view.transform = stretch
            view.frame.origin  = originalCenter
        }
    }


}
