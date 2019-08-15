//
//  HZListenRecommendViewModel.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/13.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HZListenRecommendViewModel: NSObject {
    var albums : [albumsModel]?
    // 数据源更新
    typealias HZAddDataBlock = () ->Void
    
    var upDataBlock : HZAddDataBlock?
}

extension HZListenRecommendViewModel {
    func refreshDataSource() {
        // 1.获取json文件路径
        let path = Bundle.main.path(forResource: "listenRecommend", ofType: "json")
        // 2.获取json文件里的内容
        let jsonData = NSData(contentsOfFile: path!)
        // 3.解析json内容
        let json = JSON(jsonData!)
        
        if let mappedObject = JSONDeserializer<albumsModel>.deserializeModelArrayFrom(json: json["data"]["albums"].description){
            self.albums = mappedObject as? [albumsModel]
            self.upDataBlock?()
        }
    }
}


extension HZListenRecommendViewModel {
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.albums?.count ?? 0
    }
}
