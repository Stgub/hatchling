//
//  SignupChooseHowVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/16/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignupChooseHowVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fbBtnTapped(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
            // can also get first or last name from public profile
        facebookLogin.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
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
                if let user = user {
                    print("CHUCK user data - \(credential)")
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(id: user.uid,userData: userData)
                }
            }
        })
    }
    func completeSignIn(id:String, userData:Dictionary<String, String>){
        // for automatic sign in
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let KeychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Chuck: Data saved to keycahain \(KeychainResult)")
        performSegue(withIdentifier: "signedUpWithFacebookSegue", sender: nil)
    }

}
