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
    
    @IBOutlet weak var productImageView: UIImageView!

    @IBOutlet weak var logoImageView: RoundPic!
    override func viewDidLoad() {
        super.viewDidLoad()

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
        let shortDescript = newProduct[postDataTypes.shortDescript]
        let longDescript = newProduct[postDataTypes.longDescript]
        let productName = newProduct[postDataTypes.name]

        let post: Dictionary<String, AnyObject> = [
               postDataTypes.name: productName as AnyObject,
            postDataTypes.shortDescript: shortDescript as AnyObject,
            postDataTypes.logoUrl : logoUrl as AnyObject,
            postDataTypes.productUrl : productUrl as AnyObject,
            postDataTypes.likes: 0 as AnyObject
        ]
        
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "mainTabViewController")
            self.present(vc, animated: false, completion: nil)
        // self.performSegue(withIdentifier: "toPostedSegue", sender: self)
        
   /*     captionField.text = ""
        imageSelected = false
        imageAdd.image = UIImage(named: "add-image")
        
        tableView.reloadData()*/
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
