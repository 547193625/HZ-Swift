//
//  HZRecommendModel.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit
import HandyJSON

// 最外层的model
struct HZHomeRecommendModel: HandyJSON {
    var msg:String?
    var ret:Int = 0
    var code:String?
    var list:[HZRecommendModel]?
}

// 里层的Model
struct HZRecommendModel: HandyJSON {
    var bottomHasMore: Bool = false
    var hasMore: Bool = false
    var list: [HZRecommendListModel]?
    var loopCount: Int = 0
    var moduleId: Int = 0
    var moduleType: String?
    var showInterestCard: Bool = false
    var title : String?
    
//    var target: LBFMTarget?
//    var recWords: [LBFMRecWords]?
    
    var categoryId: Int = 0
    var direction: String?
//    var keywords: [LBFMKeywords]?
}
struct HZRecommendListModel: HandyJSON {
    var albumId: Int = 0
    var categoryId: Int = 0
    var commentsCount: Int = 0
    var commentScore: CGFloat = 0.0
    var discountedPrice: CGFloat = 0.0
    var displayDiscountedPrice: String?
    var displayPrice: String?
    var infoType: String?
    var isDraft: Bool = false
    var isFinished: Int = 0
    var isPaid: Bool = false
    var isVipFree: Bool = false
    var lastUptrackAt: Int = 0
    var materialType: String?
    var nickname: String?
    var pic: String?
    var playsCount: Int = 0
    var price: CGFloat = 0.0
    var priceTypeEnum: Int = 0
    var priceUnit: String?
    var recSrc: String?
    var recTrack: String?
    var refundSupportType: Int = 0
    var subtitle: String?
    var title: String?
    var tracksCount: Int = 0
    var vipFreeType: Int = 0
    var coverPath: String?
    
}

struct HZFocusModel: HandyJSON {
    var data: [HZBannerData]?
    var responseId: Int = 0
    var ret : Int = 0
}

struct HZBannerData: HandyJSON {
    var adId: Int = 0
    var adType: Int = 0
    var buttonShowed: Bool = false
    var clickAction: Int = 0
    var clickTokens:[Any]?
    var clickType: Int = 0
    var cover: String?
    var description: String?
    var displayType: Int = 0
    var isAd: Bool = false
    var isInternal: Int = 0
    var isLandScape: Bool = false
    var isShareFlag: Bool = false
    var link: String?
    var name: String?
    var openlinkType: Int = 0
    var realLink: String?
    var showTokens: [Any]?
    var targetId: Int = 0
    var thirdClickStatUrls: [Any]?
    var thirdShowStatUrls: [Any]?
}

struct HZSquareModel: HandyJSON {
    var bubbleText: String?
    var contentType: String?
    var contentUpdatedAt: Int = 0
    var coverPath: String?
    var displayClass: String?
    var enableShare: Bool = false
    var id: Int = 0
    var isExternalUrl: Bool = false
    var sharePic: String?
    var subtitle: String?
    var title: String?
    var url: String?
    var properties:HZProperties?
}

struct HZProperties: HandyJSON {
    var isPaid: Bool = false
    var type: String?
    var uri: String?
    var albumId: Int = 0
}

struct HZTopBuzzModel: HandyJSON {
    var albumId: Int = 0
    var albumTitle: String?
    var commentsCounts: Int = 0
    var coverSmall: String?
    var createdAt: Int = 0
    var duration: Int = 0
    var favoritesCounts: Int = 0
    var id: Int = 0
    var isAuthorized: Bool = false
    var isFree: Bool = false
    var isPaid: Bool = false
    var nickname: String?
    var playPath32: String?
    var playPath64: String?
    var playPathAacv164: String?
    var playPathAacv224: String?
    var playsCounts: Int = 0
    var priceTypeId: Int = 0
    var sampleDuration: Int = 0
    var sharesCounts: Int = 0
    var tags: String?
    var title: String?
    var trackId: Int = 0
    var uid: Int = 0
    var updatedAt: Int = 0
    var userSource: Int = 0
}
