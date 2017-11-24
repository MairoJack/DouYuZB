//
//  CollectionBaseCell.swift
//  DouYuZB
//
//  Created by mario on 2017/11/16.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchor : AnchorModel? {
        didSet {
            guard let anchor = anchor else { return }
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            nickNameLabel.text = anchor.nickname
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL)
        }
    }
}
