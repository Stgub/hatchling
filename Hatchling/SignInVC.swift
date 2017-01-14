//
//  ViewController.swift
//  Hatchling
//
//  Created by Steven Graf on 1/13/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit


class SignInVC: UIViewController {
    
    @IBOutlet weak var birthdayScreen: UIView!
    @IBOutlet weak var genderScreen: UIView!
    @IBOutlet weak var emailLogInScreen: UIView!
    
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
    }
    
    

    
    
    @IBAction func fbBtnTapped(_ sender: Any) {
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
 
        //loginButton.center = view.center
        //view.addSubview(loginButton)
        
        // Do any additional setup after loading the view, typically from a nib.
        print("Fuck yeah we are developing")
    }
}
