//
//  ViewController.swift
//  Hatchling
//
//  Created by Steven Graf on 1/13/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4


class SignInVC: UIViewController {
    
    @IBAction func fbBtnTapped(_ sender: Any) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Fuck yeah we are developing")
    }

    private func facebookLogIn(){
        print("\(self) - Facebook login pressed")
    }
    
    class LogInViewController: UIViewController {
        @IBAction func unwindToLogIn(_ segue : UIStoryboardSegue){
            PFUser.logOut()
        }
        @IBAction func facebookLogIn(_ sender: AnyObject) {
            //FACEBOOK Login
            let permissions = ["public_profile"]
            print("fb log in")
            PFFacebookUtils.logInInBackground(withReadPermissions: permissions, block: {
                (user: PFUser?, error: NSError?) in
                print("logging in")
                if let error = error {
                    print(error)
                } else {
                    if let user = user {
                        print("user info")
                        print(user)
                        
                        self.grabUserInfo()
                        
                        self.performSegue(withIdentifier: "loggedIn", sender: self)
                        
                    }
                }
            })
            self.performSegue(withIdentifier: "loggedIn", sender: self)
        }
        func grabUserInfo(){
            // Grab facebook information
            let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters:  ["fields": "id, name, gender"])
            graphRequest?.start( completionHandler: { (connection, result, error) in
                if error != nil {
                    print(error)
                } else if let result = result{
                    
                    //PFUser.currentUser()!["gender"] = result["gender"]!
                    PFUser.current()!["name"] = result["name"]!
                    
                    
                    /*
                     let userID = result["id"]! as! String
                     //! print(userID) var userId = userID
                     
                     let facebookProfilePictureURL = "https://graph.facebook.com/" + userID + "/picture?type=large" // gets profile pictures which is public
                     if let fbpicURL = NSURL(string: facebookProfilePictureURL){
                     if let data = NSData(contentsOfURL: fbpicURL){
                     //self.userImage.image = UIImage(data: data)
                     //segmentation fault was being caused because I didn't have .image being assigned to
                     }
                     }
                     */
                    PFUser.current()?.saveInBackground()
                }
            })
        }
        
        override func viewDidAppear(_ animated: Bool) {
            if (PFUser.current()?.username) != nil{
                self.performSegue(withIdentifier: "loggedIn", sender: self)
            }
        }


}

