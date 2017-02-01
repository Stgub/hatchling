//
//  productConfirm.swift
//  Hatchling
//
//  Created by Steven Graf on 1/19/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import Firebase

class productConfirm: UIViewController {
    var newProduct:[String:Any]!
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var creatorPicture: RoundPic!
    @IBOutlet weak var prodNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!

    @IBOutlet weak var logoImageView: RoundPic!
    
    @IBOutlet weak var prodCategoriesLabel: UILabel!
    @IBOutlet weak var prodLongDescriptLabel: UILabel!
    
    @IBOutlet weak var prodShortDescriptLAbel: UILabel!
    @IBOutlet weak var prodCreatorLabel: UILabel!
    @IBOutlet weak var prodStageLabel: UILabel!
    @IBOutlet weak var prodNeedsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let prodImg = newProduct[postDataTypes.productImg]  {
            productImageView.image = prodImg as! UIImage 
        }
        if let logoImg = newProduct[postDataTypes.logoImg] {
            logoImageView.image = logoImg as! UIImage
        }
        if let productNeeds = newProduct[postDataTypes.prodNeeds] {
            prodNeedsLabel.text = productNeeds as? String
        }
        let shortDescript = newProduct[postDataTypes.shortDescript]
        let longDescript = newProduct[postDataTypes.longDescript]
        let productName = newProduct[postDataTypes.name]
        let productCategories = newProduct[postDataTypes.prodCategories]
        
        prodShortDescriptLAbel.text  = shortDescript as? String
        prodLongDescriptLabel.text = longDescript as? String
        prodNameLabel.text = productName as? String
        prodCategoriesLabel.text = productCategories as? String
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postBtnTapped(_ sender: AnyObject) {
      /*   guard let caption = captionField.text, caption != "" else {
            print("JESS: Caption must be entered")
            return
        }
        guard let img = imageAdd.image, imageSelected == true else {
            print("JESS: An image must be selected")
            return
        }*/
    
        //NEED PROTECTION HERE
        postProudctImg()
    }
    var productUrl = ""
    var logoUrl = ""
    func postProudctImg(){
        let productImg = newProduct[postDataTypes.productImg] as! UIImage

        if let productImgData = UIImageJPEGRepresentation(productImg, 0.2) {
            
            let imgUid = NSUUID().uuidString
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            
            DataService.ds.REF_POST_IMAGES.child(imgUid).put(productImgData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    print("Chuck: Unable to upload image to Firebasee torage")
                } else {
                    print("Chuck: Successfully uploaded image to Firebase storage")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                         self.productUrl = url
                        //postLogoImg(imgUrl: url)
                        self.postLogoImg()
                    }
                }
            }
        }
    }
    
    func postLogoImg(){
        let logoImg = newProduct[postDataTypes.logoImg] as! UIImage
        
        
        if let logoImgData = UIImageJPEGRepresentation(logoImg, 0.2) {
            
            let imgUid = NSUUID().uuidString
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            
            DataService.ds.REF_POST_IMAGES.child(imgUid).put(logoImgData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    print("Chuck: Unable to upload image to Firebasee torage")
                } else {
                    print("Chuck: Successfully uploaded image to Firebase storage")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                        self.logoUrl = url
                        self.postToFirebase()
                    }
                }
            }
        }
    }
    
    func postToFirebase() {
        //Required Values
        let shortDescript = newProduct[postDataTypes.shortDescript]
        let longDescript = newProduct[postDataTypes.longDescript]
        let productName = newProduct[postDataTypes.name]
        let prodStage = newProduct[postDataTypes.prodStage]
        let prodCategories = newProduct[postDataTypes.prodCategories]
        var  creatorName = "Anonymous"

        if let currentUserName = currentUser.name {
            creatorName = currentUserName
        }

        var post: Dictionary<String, AnyObject> = [
            postDataTypes.creator: creatorName as AnyObject,
            postDataTypes.name: productName as AnyObject,
            postDataTypes.shortDescript: shortDescript as AnyObject,
            postDataTypes.longDescript: longDescript as AnyObject,
            postDataTypes.logoUrl : logoUrl as AnyObject,
            postDataTypes.productUrl : productUrl as AnyObject,
            postDataTypes.likes: 0 as AnyObject,
            postDataTypes.prodStage : prodStage as AnyObject,
            postDataTypes.prodCategories: prodCategories as AnyObject
            
        ]
    
        
        //Optional Values
        if let prodNeeds = newProduct[postDataTypes.prodNeeds]{
            post[postDataTypes.prodNeeds] = prodNeeds as AnyObject
        } else { print("CHUCK - no prod needs loaded to firebase")}
        if let website = newProduct[postDataTypes.website] {
            post[postDataTypes.website] = website as AnyObject
        }
        if let facebook = newProduct[postDataTypes.facebook]{
            post[postDataTypes.facebook] = facebook as AnyObject

        }
        if let instagram = newProduct[postDataTypes.instagram]{
            post[postDataTypes.instagram] = instagram as AnyObject
        }
        if let email = newProduct[postDataTypes.email] {
            post[postDataTypes.email] = email as AnyObject
        }
        if let crowdfunding = newProduct[postDataTypes.crowdfunding] {
            post[postDataTypes.crowdfunding] = crowdfunding as AnyObject
        }
        if let twitter = newProduct[postDataTypes.twitter] {
            post[postDataTypes.twitter] = twitter as AnyObject
        }
        
        
        
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        let postId = firebasePost.key
        DataService.ds.REF_USER_CURRENT.child(userDataTypes.posts).child(postId).setValue(true)
        firebasePost.setValue(post)
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "mainTabViewController")
            self.present(vc, animated: false, completion: nil)
        }
    }


}
