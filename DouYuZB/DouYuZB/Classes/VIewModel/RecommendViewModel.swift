//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by mario on 2017/11/15.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseViewModel {
    
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    private lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
}

// MARK:- 发送网络请求
extension RecommendViewModel {
    //请求推荐数据
    func requestData(finishCallback : @escaping () -> ()) {
        
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime() as NSString]
        let disGroup = DispatchGroup.init()
        
        // 1.请求第一部分推荐数据
        disGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom",parameters: ["time" : NSDate.getCurrentTime() as NSString]) { (result) in
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            //2.获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            disGroup.leave()
        }
        // 2.请求第二部分颜值数据
        disGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom",parameters: parameters) { (result) in
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            //2.获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //3.便利数组
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            disGroup.leave()
        }
        
        // 3.请求后面部分的游戏数据
        disGroup.enter()
        
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters:  ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime() as NSString]) {
            disGroup.leave()
        }
       
        
        disGroup.notify(queue: .main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
    }
    
    func requestCycleData(finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/slide/6",parameters: ["version" : "2.300"]) { (result) in
            
            guard let resultDict = result as? [String : NSObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return  }
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            finishCallback()
            
        }
    }
}
