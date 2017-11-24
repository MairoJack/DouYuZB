//
//  BaseViewController.swift
//  DouYuZB
//
//  Created by mario on 2017/11/21.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var contentView : UIView?
    
    fileprivate lazy var animImageView : UIImageView = {[unowned self] in
        let imgaeView = UIImageView(image: UIImage(named: "img_loading_1"))
        imgaeView.center = self.view.center
        imgaeView.animationImages = [UIImage(named : "img_loading_1")!,UIImage(named : "img_loading_2")!]
        imgaeView.animationDuration = 0.5
        imgaeView.animationRepeatCount = LONG_MAX
        imgaeView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imgaeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        contentView?.isHidden = true
        view.addSubview(animImageView)
        animImageView.startAnimating()
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    
    func loadDataFinished() {
        animImageView.stopAnimating()
        animImageView.isHidden = true
        contentView?.isHidden = false
    }

}
