//
//  UpdateConfirmVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/2/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class UpdateConfirmVC: UIViewController {
    var update:Update!
    
    @IBOutlet weak var updateDescript: UILabel!
    
    @IBOutlet weak var updateLink: UIButton!
    
    @IBAction func tappedSubmitBtn(_ sender: Any) {
        PostManager.pm.submitUpdate(newUpdate: update, withCompletionBlock: {
            (error) in
            if error == nil {
                if let storyboard = self.storyboard {
                    let vc = storyboard.instantiateViewController(withIdentifier: "mainTabViewController")
                    self.present(vc, animated: false, completion: nil)
                }
            } else {
                presentUIAlert(sender: self, title: "Eror submitting", message: "Please try again")
            }
        })
        
    }
    @IBAction func tappedBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDescript.text = update.description
        updateLink.setTitle(update.link, for: .normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

    


}
