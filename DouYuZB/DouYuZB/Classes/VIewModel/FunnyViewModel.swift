//
//  FunnyViewModel.swift
//  DouYuZB
//
//  Created by mario on 2017/11/21.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel {
    func loadFunnyData(finishedCallback : @escaping ()->()){
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/3", parameters: ["limit" : "30","offset":"0"], finishedCallback: finishedCallback)
    }
}
