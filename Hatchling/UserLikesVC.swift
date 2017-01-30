//
//  UserLikesVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/29/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import Firebase

class UserLikesVC: UITableViewController {

    var usersLikes:[Post] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.getUsersLike()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersLikes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "likesTableViewCell", for: indexPath) as! LikesTableViewCell
        let post = usersLikes[indexPath.row]
        cell.prodName.text = post.name
        cell.prodShortDescript.text = post.shortDescript
        //cell.prodLogoImg.image = post.logoImg
        return cell
    }
    func getUsersLike(){
        DataService.ds.REF_USER_CURRENT.child(userDataTypes.likes).observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.usersLikes.append(post)
                    }
                }
            }
        })
    }
    


}
