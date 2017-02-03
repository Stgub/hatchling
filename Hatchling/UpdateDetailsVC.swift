//
//  UpdateDetailsVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/2/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class UpdateDetailsVC: UIViewController {
    var update:Update!
    
    @IBOutlet weak var updateDescript: textViewRoundCorners!
    @IBOutlet weak var updateLink: UITextField!
    
    @IBAction func tappedBackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedNextBtn(_ sender: Any) {
        if updateDescript.text == ""  {
            presentUIAlert(title: "Description not filled out", message: "Please fill in Description")
            update.description = updateDescript.text
            update.link = updateLink.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        switch(dest){
        case is UpdateConfirmVC:
            let destVC = dest as! UpdateConfirmVC
            destVC.update = update
        default:
            print("Default")
        }
    }
    
    func presentUIAlert(title:String, message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }

}
