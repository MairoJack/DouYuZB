//
//  CollectionPrettyCell.swift
//  DouYuZB
//
//  Created by mario on 2017/11/14.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionPrettyCell : CollectionBaseCell {

    @IBOutlet weak var cityLabel: UIButton!
    
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            cityLabel.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
}
