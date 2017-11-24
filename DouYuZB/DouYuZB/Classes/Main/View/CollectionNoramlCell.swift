//
//  CollectionNoramlCell.swift
//  DouYuZB
//
//  Created by mario on 2017/11/14.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit

class CollectionNoramlCell: CollectionBaseCell {

    @IBOutlet weak var roomLabel: UILabel!
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            roomLabel.text = anchor?.room_name
        }
    }

}
