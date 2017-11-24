//
//  RecommendViewController.swift
//  DouYuZB
//
//  Created by mario on 2017/11/14.
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

class RecommendViewController: BaseAnchorViewController {

    // MARK:- 懒加载属性
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    
    private lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    

    override func setupUI() {
        super.setupUI()
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH , left: 0, bottom: 0, right: 0)
    }
    
    override func loadData() {
        
        baseVM = recommendVM
        
        recommendVM.requestData {
            //展示推荐数据
            self.collectionView.reloadData()
            
            var groups = self.recommendVM.anchorGroups
            groups.removeFirst()
            groups.removeFirst()
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            //将数据传递给GameView
            self.gameView.groups = groups
            
            self.loadDataFinished()
        }
        
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}


extension RecommendViewController  {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        var cell : CollectionBaseCell!
        
        if indexPath.section == 1 {
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
        } else {
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNoramlCell
        }
        cell.anchor = anchor
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: KItemW, height: kPrettyItemH)
        }
        return CGSize(width: KItemW, height: kNormalItemH)
    }
}
