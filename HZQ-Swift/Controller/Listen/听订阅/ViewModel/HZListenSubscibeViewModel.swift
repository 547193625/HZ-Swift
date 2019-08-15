//
//  HZListenSubscibeViewModel.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/12.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

// --- 数据源更新
typealias HZAddDataBlock = () ->Void

class HZListenSubscibeViewModel: NSObject {
    var  albumResults:[AlbumResultsModel]?
    var upDataBlock: HZAddDataBlock?
}

// 请求数据
extension HZListenSubscibeViewModel {
    func  refreshDataSource() {
        // 1.获取json文件路径
        let path = Bundle.main.path(forResource: "listenSubscibe", ofType: "json")
        
        let jsonData = NSData(contentsOfFile: path!)
        
        let  json = JSON(jsonData!)
        
        if let mappedObject = JSONDeserializer<AlbumResultsModel>.deserializeModelArrayFrom(json: json["data"]["albumResults"].description) {
            self.albumResults = mappedObject as? [AlbumResultsModel]
            self.upDataBlock?()
        }
    }
}

extension HZListenSubscibeViewModel {
    // 每个分区显示item的数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.albumResults?.count ?? 0
    }
}
