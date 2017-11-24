//
//  CustomNavigationController.swift
//  DouYuZB
//
//  Created by mario on 2017/11/21.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }

}
