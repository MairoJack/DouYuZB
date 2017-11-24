//
//  GameViewModel.swift
//  DouYuZB
//
//  Created by mario on 2017/11/21.
//  Copyright © 2017年 mario. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games : [GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadAllGamesData(finishedCallback : @escaping() -> ()) {
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName":"game"]) { (result) in
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            
            finishedCallback()
        }
    }
}
