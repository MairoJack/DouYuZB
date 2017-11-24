//
//  BaseAnchorViewController.swift
//  DouYuZB
//
//  Created by mario on 2017/11/21.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let KItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = KItemW * 3 / 4
private let kPrettyItemH = KItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class BaseAnchorViewController: BaseViewController {

    var baseVM : BaseViewModel!
    
    lazy var collectionView : UICollectionView = {
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        collectionView.register(UINib(nibName: "CollectionNoramlCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        loadData()
    }


    override func setupUI() {
        contentView = collectionView
        view.addSubview(collectionView)
        super.setupUI()
    }
    
    func loadData(){}
}

extension BaseAnchorViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNoramlCell
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
    
    
}

extension BaseAnchorViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        anchor.isVertical == 0 ? pushNoramlRoomVc() : presentShowRoomVc()
    }
    
    private func presentShowRoomVc() {
        let showRoomVc = RoomShowViewController()
        present(showRoomVc, animated: true, completion: nil)
    }
    
    private func pushNoramlRoomVc() {
        let normalRoomVc = RoomNoramlViewController()
        navigationController?.pushViewController(normalRoomVc, animated: true)
    }
}
