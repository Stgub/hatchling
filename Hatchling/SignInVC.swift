//
//  ViewController.swift
//  Hatchling
//
//  Created by Steven Graf on 1/13/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import Parse
import FBSDKLoginKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var fbBtn: ShadowAndPillBtn!
    
    @IBOutlet weak var emailSignInScreen: UIView!
    @IBAction func emailBtnTapped(_ sender: Any) {
        emailSignInScreen.isHidden = false
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        emailSignInScreen.isHidden = true
    }

    @IBAction func emailLogInBtnTapped(_ sender: Any) {
    }
    
    
    @IBAction func fbBtnTapped(_ sender: Any) {
        let fbLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self)  { (result, error) in
            print("logging in")
            if error != nil {
                print(" Chuck - unable to authenticate with Facebook \(error)")
            } else if result?.isCancelled == true {
                print(" Chuck - User cancelled Facebook Authentication")
            
            } else {
                print(" Chuck - Successfully authenticated with Facebook")
            
            }
        
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        //loginButton.center = view.center
        //view.addSubview(loginButton)
        
        // Do any additional setup after loading the view, typically from a nib.
        print("Fuck yeah we are developing")
    }
}
