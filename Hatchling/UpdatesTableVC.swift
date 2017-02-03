//
//  UpdatesTableVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/3/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class UpdatesTableVC: UIViewController, UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    let usersLikesUpdates:[Updates] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PostManager.pm.getUsersLikesUpdates { (updates) in
            self.usersLikesUpdates = updates
            tableView.reloadData()
        }
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersLikesUpdates.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "updatesTableViewCell") as! UpdatesTableViewCell
        let update = usersLikesUpdates[indexPath.row]
        cell.updateDescript.text = update.description
        cell.prodName.text = update.name
        cell.update = update
        PostManager.pm.getImage(imgUrl: update.prodLogoUrl, returnBlock: {
            (returnedImg) in
            cell.prodLogo.image = returnedImg
        })
        return cell
    }
}
