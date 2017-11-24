//
//  PageContentView.swift
//  DouYuZB
//
//  Created by mario on 2017/11/13.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit

protocol PageCotentViewDelegate : class {
    func pageCotentView(contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let ContentCellID  = "ContentCellID"

class PageContentView: UIView {

    // MARK:-定义属性
    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var startOffsetX : CGFloat = 0
    weak var delegate : PageCotentViewDelegate?
    private var isForbidScrollDelegate : Bool = false
    
    private lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
    
    
    init(frame: CGRect , childVcs : [UIViewController] , parentViewController : UIViewController) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame:frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView {
    private func setupUI() {
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}

extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
}

extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate { return }
        
        //1.定义获取需要的数据
        var progress : CGFloat = 0
        var scourceIndex : Int = 0
        var targetIndex :Int = 0
        
        //2.判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX {      //左滑
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.计算scourceIndex
            scourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            targetIndex = scourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = scourceIndex
            }
        } else {    //右滑
            // 1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算scourceIndex
            scourceIndex = targetIndex + 1
            if scourceIndex >= childVcs.count {
                scourceIndex = childVcs.count - 1
            }
        }
        
        
        delegate?.pageCotentView(contentView: self, progress: progress, sourceIndex: scourceIndex, targetIndex: targetIndex)
        
    }
}
// MARK :- 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    }
}
