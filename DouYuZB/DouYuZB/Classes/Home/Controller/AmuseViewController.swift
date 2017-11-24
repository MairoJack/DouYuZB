//
//  AmuseViewController.swift
//  DouYuZB
//
//  Created by mario on 2017/11/21.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController{
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
    
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
    override func loadData() {
        baseVM = amuseVM
        
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
            
            var tempGrpups = self.amuseVM.anchorGroups
            tempGrpups.removeFirst()
            self.menuView.groups = tempGrpups
            
            self.loadDataFinished()
        }
    }
}

extension AmuseViewController {
    
}









