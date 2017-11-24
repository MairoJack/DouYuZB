//
//  CollectionGameCell.swift
//  DouYuZB
//
//  Created by mario on 2017/11/17.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var baseGame : BaseGameModel? {
        didSet {
            titleLabel.text = baseGame?.tag_name
            let iconURL = URL(string: baseGame?.icon_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_more_btn"))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
