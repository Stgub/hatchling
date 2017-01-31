//
//  PostDetailViewVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/29/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class PostDetailVC: UITableViewCell {

    
    
    @IBOutlet weak var prodImg: UIImageView!
    
    @IBOutlet weak var prodLogoImg: RoundPic!
    
    @IBOutlet weak var prodCreatorImg: RoundPic!
    
    @IBOutlet weak var prodName: UILabel!
    
    @IBOutlet weak var prodShortDescript: UILabel!
    
    @IBOutlet weak var prodLongDescript: UILabel!
    @IBOutlet weak var prodStage: UILabel!
    
    @IBOutlet weak var prodNeeds: UILabel!
    
    @IBOutlet weak var prodCategories: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
