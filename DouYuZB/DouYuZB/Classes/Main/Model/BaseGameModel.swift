//
//  BaseGameModel.swift
//  DouYuZB
//
//  Created by mario on 2017/11/21.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit
@objcMembers
class BaseGameModel: NSObject {
    var tag_name : String = ""
    var icon_url : String = ""
    
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
