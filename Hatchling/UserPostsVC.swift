//
//  UserPostsVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/29/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import Firebase

class UserPostsVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var usersPosts:[Post] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        getUsersPosts() //may not be able to us this here??
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersPosts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postsTableViewCell") as! PostsTableViewCell
        let post = usersPosts[indexPath.row]
        cell.prodLikes.text = "\(post.likes)"
        cell.prodName.text = post.name
        //cell.prodLogo.image = post.logoImg // Need to load the image at som point
        cell.prodViews.text = "\(post.totalViews)"

        return cell
    }
    func getUsersPosts(){
        DataService.ds.REF_USER_CURRENT.child(userDataTypes.posts).observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.usersPosts.append(post)
                    }
                }
            }
        })
        
    }
}
