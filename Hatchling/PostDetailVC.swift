//
//  PostDetailViewVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/29/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class PostDetailVC: UIViewController {

    var post:Post!
    
    
    @IBOutlet weak var prodImg: UIImageView!
    
    @IBOutlet weak var prodLogoImg: RoundPic!
    
    @IBOutlet weak var prodCreatorImg: RoundPic!
    
    @IBOutlet weak var prodName: UILabel!
    
    @IBOutlet weak var prodShortDescript: UILabel!
    
    @IBOutlet weak var prodLongDescript: UILabel!
    @IBOutlet weak var prodStage: UILabel!
    
    @IBOutlet weak var prodNeeds: UILabel!
    
    @IBOutlet weak var prodCategories: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
