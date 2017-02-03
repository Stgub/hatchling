//
//  UpdatesTableViewCell.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/2/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class UpdatesTableViewCell: UITableViewCell {

    @IBOutlet weak var updateLogo: RoundPic!
    
    @IBOutlet weak var updateProdName: UILabel!
    
    @IBOutlet weak var updateDescript: UILabel!
    
    @IBOutlet weak var updateLink: UIButton!
    
    @IBAction func tappedLinkBtn(_ sender: Any) {
        print("CHUCK: one day this will bring you to the link")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
