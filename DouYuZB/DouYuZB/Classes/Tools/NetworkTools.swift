//
//  NetworkTools.swift
//  DouYuZB
//
//  Created by mario on 2017/11/15.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}
class NetworkTools {
    class func requestData(type : MethodType, URLString : String,
                           parameters : [String : NSString]? = nil, finishedCallback : @escaping (AnyObject) -> ()) {
        
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters : parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error as Any)
                return
            }
            finishedCallback(result as AnyObject)
        }
    }
}
