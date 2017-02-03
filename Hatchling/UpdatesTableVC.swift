//
//  UpdatesTableVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/2/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class UpdatesTableVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var usersLikesUpdates:[Update] = []

    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersLikesUpdates.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "updatesTableViewCell") as! UpdatesTableViewCell
        let update = usersLikesUpdates[indexPath.row]
        cell.updateProdName.text = update.name
        cell.updateDescript.text = update.description
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        PostManager.pm.getUsersLikesUpdates(withCompletionBlock: {
            returnedUpdates in
            self.usersLikesUpdates = returnedUpdates
        })
        // Do any additional setup after loading the view.
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
