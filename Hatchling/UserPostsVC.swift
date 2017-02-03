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
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PostManager.pm.getUsers(userDataType: userDataTypes.posts, returnBlock: {
            (returnedPosts) in
            self.usersPosts = returnedPosts
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
        cell.post = post 
        cell.prodLikes.text = "\(post.likes)"
        cell.prodName.text = post.name
        cell.userPostsVC = self
        PostManager.pm.getImage(imgUrl: post.logoUrl, returnBlock: {
            (returnedImg) in
            cell.prodLogo.image = returnedImg
        })
        //cell.prodLogo.image = post.logoImg // Need to load the image at som point
        cell.prodViews.text = "\(post.totalViews)"

        return cell
    }
    
    func createUpdate(forPost:Post){
        selectedPost = forPost
        self.performSegue(withIdentifier: "toCreateUpdateSegue", sender: self)
    }
    var selectedPost:Post!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPost = usersPosts[indexPath.row]
        self.performSegue(withIdentifier: "toUserPostSegue", sender: self)
    }
    
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        switch(dest ){
        case is UsersPostDetailVC:
            let destVC = dest as! UsersPostDetailVC
            destVC.post = selectedPost
        case is ChooseUpdateTypeVC:
            let destVC = dest as! ChooseUpdateTypeVC
            destVC.post = selectedPost
        default:
            print("Default")
        }
    }
}
