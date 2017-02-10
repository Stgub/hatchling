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
func presentUIAlert(sender: UIViewController, title:String, message:String){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(defaultAction)
    sender.present(alertController, animated: true, completion: nil)
    
}
    
