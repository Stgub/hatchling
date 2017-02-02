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
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var usersPosts:[Post] = []
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PostManager.pm.getUsers(userDataType: userDataTypes.posts, returnBlock: {
            (returnPosts) in
            self.usersPosts = returnPosts
            self.tableView.reloadData()
            
        })
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
        PostManager.pm.getImage(imgUrl: post.logoUrl, returnBlock: {
            (returnedImg) in
            cell.prodLogo.image = returnedImg
        })
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
