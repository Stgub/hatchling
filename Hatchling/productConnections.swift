//
//  productConnections.swift
//  Hatchling
//
//  Created by Steven Graf on 1/19/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class productConnections: UIViewController {
    
    var newProduct:[String:Any]!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toProductConfirmSegue", sender: self)
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
        case is productConfirm:
            let destVC = dest as! productConfirm
            destVC.newProduct = newProduct
        default:
            print("Default in switch statment")
        }
    
    }
    

}
