//
//  BaseViewModel.swift
//  DouYuZB
//
//  Created by mario on 2017/11/21.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(URLString : String, parameters : [String : Any]? = nil,finishedCallback : @escaping () -> ()) {
        
        NetworkTools.requestData(type: .GET, URLString: URLString,parameters: parameters as? [String : NSString]) { (result) in
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            
            finishedCallback()
        }
    }
}
