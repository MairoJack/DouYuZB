//
//  FunnyViewController.swift
//  DouYuZB
//
//  Created by mario on 2017/11/21.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit
private let kTopMargin : CGFloat = 8
class FunnyViewController: BaseAnchorViewController {

    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()
    
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
    
    override func loadData() {
        baseVM = funnyVM
        
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
            self.loadDataFinished()
        }
    }
}


