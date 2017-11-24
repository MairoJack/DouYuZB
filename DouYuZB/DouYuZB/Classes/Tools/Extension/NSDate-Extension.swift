//
//  NSDate-Extension.swift
//  DouYuZB
//
//  Created by mario on 2017/11/15.
//  Copyright © 2017年 mario. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        
        let interval = nowDate.timeIntervalSince1970
        
        return "\(interval)"
    }
}
