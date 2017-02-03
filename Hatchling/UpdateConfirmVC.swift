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
    
    @IBAction func tappedSubmitBtn(_ sender: UIButton) {
        PostManager.pm.submitUpdate(newUpdate: update, withCompletionBlock:  {
            error in
            if error == nil {
                if let storyboard = self.storyboard {
                    let vc = storyboard.instantiateViewController(withIdentifier: "mainTabViewController")
                    self.present(vc, animated: false, completion: nil)
                }
            } else {
                print("CHUCK: Issue posting update -\(error)")
            }
        })

    }
    @IBAction func tappedBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func linkTapped(_ sender: Any) {
        print("CHUCK: make this go to a website one day")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDescript.text = update.description
        updateLink.setTitle(update.link, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
