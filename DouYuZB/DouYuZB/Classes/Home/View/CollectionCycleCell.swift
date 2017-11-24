//
//  CollectionCycleCell.swift
//  DouYuZB
//
//  Created by mario on 2017/11/16.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")
            
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"), options: nil)
        }
    }

}
