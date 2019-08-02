//
//  HZRecommendViewModel.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HZRecommendViewModel: NSObject {
    // MARK - 数据模型
    var fmhomeRecommendModel:HZHomeRecommendModel?
    var homeRecommendList:[HZRecommendModel]?
    var recommendList : [HZRecommendListModel]?
    var focus:HZFocusModel?
    var squareList:[HZSquareModel]?
    var topBuzzList: [HZTopBuzzModel]?
    
    // Mark:--数据源更新
    typealias AddDataBlock = () ->Void
    var  updateDataBlock:AddDataBlock?
}

extension HZRecommendViewModel {
    func  refreshDataSource() {
        // 从首页推荐接口请求
        HZRecommendProvider.request(.recommendList){ result in
            if case let .success(resopnse) = result {
                // 解析数据
                let data = try?resopnse.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HZHomeRecommendModel>.deserializeFrom(json: json.description) { // 从字符串转换为对象实例
                    self.fmhomeRecommendModel = mappedObject
                    self.homeRecommendList = mappedObject.list
                    if let recommendList = JSONDeserializer<HZRecommendListModel>.deserializeModelArrayFrom(json: json["list"].description) {
                        self.recommendList = recommendList as? [HZRecommendListModel]
                    }
                    
                    if let focus = JSONDeserializer<HZFocusModel>.deserializeFrom(json: json["list"][0]["list"][0].description) {
                        self.focus = focus
                    }
                    if let square = JSONDeserializer<HZSquareModel>.deserializeModelArrayFrom(json: json["list"][1]["list"].description) {
                        self.squareList = square as? [HZSquareModel]
                    }
                    if let topBuzz = JSONDeserializer<HZTopBuzzModel>.deserializeModelArrayFrom(json: json["list"][2]["list"].description) {
                        self.topBuzzList = topBuzz as? [HZTopBuzzModel]
                    }
                    
//                    if let oneKeyListen = JSONDeserializer<LBFMOneKeyListenModel>.deserializeModelArrayFrom(json: json["list"][9]["list"].description) {
//                        self.oneKeyListenList = oneKeyListen as? [LBFMOneKeyListenModel]
//                    }
//
//                    if let live = JSONDeserializer<LBFMLiveModel>.deserializeModelArrayFrom(json: json["list"][14]["list"].description) {
//                        self.liveList = live as? [LBFMLiveModel]
//                    }
                    self.updateDataBlock?()
                }
            }
        }
    }
}


extension HZRecommendViewModel {
    func numberOfSections(collectionView:UICollectionView) -> Int {
        return (self.homeRecommendList?.count) ?? 0;
    }
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        return 1
    }
    //每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //最小 item 间距
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    
    //最小行间距
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    
    // item尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        let HeaderAndFooterHeight:Int = 90
        let itemNums = (self.homeRecommendList?[indexPath.section].list?.count)!/3
        let count = self.homeRecommendList?[indexPath.section].list?.count
        let moduleType = self.homeRecommendList?[indexPath.section].moduleType
        if moduleType == "focus" {
            return CGSize.init(width:LBFMScreenWidth,height:360)
        }else if moduleType == "square" || moduleType == "topBuzz" {
            return CGSize.zero
        }else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory" || moduleType == "live"{
            return CGSize.init(width:LBFMScreenWidth,height:CGFloat(HeaderAndFooterHeight+180*itemNums))
        }else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore"{
            return CGSize.init(width:LBFMScreenWidth,height:CGFloat(HeaderAndFooterHeight+120*count!))
        }else if moduleType == "ad" {
            return CGSize.init(width:LBFMScreenWidth,height:240)
        }else if moduleType == "oneKeyListen" {
            return CGSize.init(width:LBFMScreenWidth,height:180)
        }else {
            return .zero
        }
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        let moduleType = self.homeRecommendList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" || moduleType == "ad" || section == 18 {
            return CGSize.zero
        }else {
            return CGSize.init(width: LBFMScreenHeight, height:40)
        }
    }
    
    // 分区尾视图size
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        let moduleType = self.homeRecommendList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" {
            return CGSize.zero
        }else {
            return CGSize.init(width: LBFMScreenWidth, height: 10.0)
        }
    }
}
