//
//  ViewController.swift
//  Hatchling
//
//  Created by Steven Graf on 1/13/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var birthdayScreen: UIView!
    @IBOutlet weak var genderScreen: UIView!
    @IBOutlet weak var emailLogInScreen: UIView!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    @IBAction func emailBtnTapped(_ sender: Any) {
        birthdayScreen.isHidden = false
    }
    
    @IBAction func bdayBackBtnTapped(_ sender: Any) {
        birthdayScreen.isHidden = true
    }
    
    @IBAction func bdayNextBtnTapped(_ sender: Any) {
        genderScreen.isHidden = false
    }
    
    @IBAction func genderBackBtnTapped(_ sender: Any) {
        genderScreen.isHidden = true
    }
    
    @IBAction func genderNextBtnTapped(_ sender: Any) {
        emailLogInScreen.isHidden = false
    }
    
    @IBAction func emailBackBtnTapped(_ sender: Any) {
        emailLogInScreen.isHidden = true
        
        if let email = emailField.text, let pwd = pwdField.text{
            
        }
    }
    
    

    
    
    @IBAction func fbBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: [ "email"], from: self) { (result, error) in
            if error != nil {
                print("Chuck: Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("Chuck: User cancelled Facebook authentication")
            } else {
                print("Chuck: Successfully authenticated with Facebook")
                //Authenticate with Facebook
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                //Authenticatre with Firebase
                self.firebaseAuth(credential)
            }
        }
    }
    func firebaseAuth(_ credential: FIRAuthCredential){
            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                if error != nil {
                    print("Chuck: Unabe to authenticate with Firebase - \(error)")
                } else {
                    print("Chuck: Succesfully authenticated with Firebase")
                }
            })
        
        
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
 
        //loginButton.center = view.center
        //view.addSubview(loginButton)
        
        // Do any additional setup after loading the view, typically from a nib.
        print("Fuck yeah we are developing")
    }
}
