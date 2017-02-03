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
        PostManager.pm.submitUpdate(newUpdate: update)
        
    }
    @IBAction func tappedBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDescript.text = update.description
        updateLink.titleLabel?.text = update.link
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
