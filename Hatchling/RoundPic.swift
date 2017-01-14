//
//  RoundPic.swift
//  Hatchling
//
//  Created by Steven Graf on 1/14/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class RoundPic: UIImageView {

    override func awakeFromNib() {
        layer.cornerRadius = self.frame.width / 2
    }

}
