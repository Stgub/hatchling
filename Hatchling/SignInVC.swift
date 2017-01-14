//
//  ViewController.swift
//  Hatchling
//
//  Created by Steven Graf on 1/13/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit


class SignInVC: UIViewController {
    
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
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Fuck yeah we are developing")
    }
}
