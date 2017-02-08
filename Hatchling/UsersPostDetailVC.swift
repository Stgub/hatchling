//
//  UsersPostDetailVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/2/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class UsersPostDetailVC: UIViewController {
    var post:Post!
    
    
    @IBOutlet weak var postName: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var postLogoImg: RoundPic!
    @IBOutlet weak var postShortDescript: UILabel!
    
    @IBOutlet weak var postLongDescript: UILabel!
    
    @IBOutlet weak var postCreatorsName: UILabel!
    
    @IBOutlet weak var postNeeds: UILabel!
    @IBOutlet weak var postStage: UILabel!
    @IBOutlet weak var postCategories: UILabel!
    
    @IBAction func tappedBackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = post.name{
            print(name )
            postName.text = name
        }
        if let shortDescript = post.shortDescript {
            postShortDescript.text = shortDescript
        }
        if let longDescript = post.longDescript{
            postLongDescript.text = longDescript
        }
        
        DataManager.dm.getImage(imgUrl: post.productUrl, returnBlock: {
            (returnedImg) in
            self.postImg.image = returnedImg
        })
        DataManager.dm.getImage(imgUrl: post.logoUrl, returnBlock: {
            (returnedImg) in
            self.postLogoImg.image = returnedImg
        })
        if let stage = post.prodStage {
            postStage.text = stage
        }
        if let creatorsName = post.creatorName {
            postCreatorsName.text = creatorsName
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
