//
//  CycleModel.swift
//  DouYuZB
//
//  Created by mario on 2017/11/16.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit

@objcMembers
class CycleModel: NSObject {
    //标题
    var title : String = ""
    //图片地址
    var pic_url : String = ""
    //主播信息对应的字典
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    //主播信息对应的模型对象
    var anchor : AnchorModel?
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
