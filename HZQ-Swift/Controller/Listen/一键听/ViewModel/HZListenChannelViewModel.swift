//
//  HZListenChannelViewModel.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/13.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class HZListenChannelViewModel: NSObject {
    var channelResults:[ChannelResultsModel]?
    typealias HZAddDataBlock = () ->Void
    // 数据源更新
    var upDataBlock:HZAddDataBlock?
}

// ---请求数据
extension HZListenChannelViewModel {
    func refreshDataSource() {
        // 一键听接口请求
        HZListenProvider.request(.listenChannelList) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 从字符串转换为对象实例
                if let mappedObject = JSONDeserializer<ChannelResultsModel>.deserializeModelArrayFrom(json: json["data"]["channelResults"].description){
                    self.channelResults = mappedObject as? [ChannelResultsModel]
                    self.upDataBlock?()
                }
            }
        }
    }
}

extension HZListenChannelViewModel {
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.channelResults?.count ?? 0
    }
}
