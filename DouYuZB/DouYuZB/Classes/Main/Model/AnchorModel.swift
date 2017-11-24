//
//  AnchorModel.swift
//  DouYuZB
//
//  Created by mario on 2017/11/16.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit

@objcMembers
class AnchorModel: NSObject {
    var room_id : Int = 0
    var vertical_src : String = ""
    // 0:电脑直播 1:手机直播
    var isVertical : Int = 0
    var room_name : String = ""
    //主播昵称
    var nickname : String = ""
    //在线人数
    var online : Int = 0
    //所在城市
    var anchor_city : String = ""
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
