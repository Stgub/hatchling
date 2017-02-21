//
//  GeneralFunctions.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/16/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import Foundation
import UIKit
 //Simple UIalert function...
func presentUIAlert(sender: UIViewController, title:String, message:String, action: ()?=nil){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    if action == nil {
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)

    } else {
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            uialertAction in
            //run your function here
           action!
        }))
    }


    sender.present(alertController, animated: true, completion: nil)
    
}
   /**
    Performs a segue from whatever UIViewController to the Feed VC
 */
func presentMainTabVC(sender: UIViewController){
    let storyboard = UIStoryboard(name: hatchlingStoryboards.main, bundle: Bundle.main)
    let vc = storyboard.instantiateViewController(withIdentifier: "mainTabViewController")
    sender.present(vc, animated: true, completion: nil)
}
func presentSignUpOrLoginVC(sender:UIViewController){
    let storyboard = UIStoryboard(name: hatchlingStoryboards.logOrSignIn, bundle: Bundle.main)
    let vc = storyboard.instantiateViewController(withIdentifier: "SignUpOrLogInViewController")
    sender.present(vc, animated: true, completion: nil)
}
func presentCreatProductDetailsVC(sender:UIViewController){
    let storyboard = UIStoryboard(name: hatchlingStoryboards.createProduct, bundle: Bundle.main)
    let vc = storyboard.instantiateViewController(withIdentifier: "CreateProductDetailsVC")
    sender.present(vc, animated: true, completion: nil)
}
