//
//  UserLikesVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/29/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import Firebase

class UserLikesVC: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var usersLikedPostsKeys:[String] = []
    var usersLikes:[Post] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.getUsersLikes()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    // MARK: - Table view data source


     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersLikes.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "likesTableViewCell", for: indexPath) as! LikesTableViewCell
        let post = usersLikes[indexPath.row]
        cell.prodName.text = post.name
        cell.prodShortDescript.text = post.shortDescript
        //cell.prodLogoImg.image = post.logoImg
        return cell
    }
    func getUsersLikes(){
        DataService.ds.REF_USER_CURRENT.child(userDataTypes.likes).observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    print("SNAP: \(snap)")
                    let key = snap.key
                    self.usersLikedPostsKeys.append(key)
                
                }
                self.loadUsersLikes()
            }
        })
    }
    func loadUsersLikes(){
        DataService.ds.REF_POSTS.observeSingleEvent(of: .value, with: {
            (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    let key = snap.key
                    if self.usersLikedPostsKeys.contains(snap.key){
                        if let postData = snap.value as? Dictionary<String, AnyObject>{
                            let post = Post(postKey: key, postData: postData)
                            self.usersLikes.append(post)
                        }

                    }
                }
            }
            self.tableView.reloadData()
            }
        )
    }
    


}
