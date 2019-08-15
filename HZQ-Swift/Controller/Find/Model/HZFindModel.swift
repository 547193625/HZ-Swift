//
//  HZFindModel.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/14.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import Foundation
import HandyJSON

// 关注动态 Model
struct HZEventInfosModel: HandyJSON {
    var authorInfo:HZAttentionAuthorInfo?
    var contentInfo: HZFindAContentInfo?
    var eventTime: NSInteger = 0
    var id: NSInteger = 0
    var isFromRepost: Bool = false
    var isPraise: Bool = false
    var statInfo: HZFindAStatInfo?
    var timeline: NSInteger = 0
    var type: Int = 0
    
}
struct HZAttentionAuthorInfo: HandyJSON {
    var anchorGrade:Int = 0
    var avatarUrl: String?
    var isV: Bool = false
    var isVip: Bool = false
    var nickname: String?
    var uid: NSInteger = 0
    var userGrade: Int = 0
    var verifyType: Int = 0
}

struct HZFindAContentInfo: HandyJSON {
    var picInfos: [HZFindAPicInfos]?
    var text:String?
}

struct HZFindAPicInfos: HandyJSON {
    var id: NSInteger = 0
    var originUrl: String?
    var rectangleUrl:String?
    var squareUrl: String?
}

struct HZFindAStatInfo: HandyJSON {
    var commentCount: Int = 0
    var praiseCount: Int = 0
    var repostCount: Int = 0
}

/// 推荐动态 Model
struct HZFindRecommendModel: HandyJSON {
    var emptyTip: String?
    var endScore: Int = 0
    var hasMore: Bool = false
    var pullTip: String?
    var startScore: Int = 0
    var streamList: [HZFindRStreamList]?
}

struct HZFindRStreamList: HandyJSON {
    var avatar: String?
    var commentsCount: Int = 0
    var content: String?
    var id: Int = 0
    var issuedTs: Int = 0
    var liked: Bool = false
    var likesCount: Int = 0
    var nickname: String?
    var picUrls: [HZFindRPicUrls]?
    var recSrc: String?
    var recTrack: String?
    var score: Int = 0
    var subType: Bool = false
    var type: String?
    var uid : Int = 0
}
struct HZFindRPicUrls: HandyJSON {
    var originUrl: String?
    var thumbnailUrl: String?
}


/// 趣配音 Model
struct HZFMFindDudModel: HandyJSON {
    var data:[HZFindDudModel]?
}

struct HZFindDudModel: HandyJSON {
    var dubbingItem: HZFindDuddubbingItem?
    var feedItem: HZFindDudfeedItem?
}

struct HZFindDuddubbingItem: HandyJSON {
    var commentCount: Int = 0
    var coverLarge: String?
    var coverMiddle: String?
    var coverPath: String?
    var coverSmall: String?
    var createAt: NSInteger = 0
    var duration: Int = 0
    var favorites: Int = 0
    var intro: String?
    var logoPic: String?
    var mediaType: String?
    var nickname: String?
    var playPathAacv164: String?
    var playPathAacv224: String?
    var relatedId: Int = 0
    var title: String?
    var topicId: Int = 0
    var topicTitle: String?
    var topicUrl: String?
    var trackId: Int = 0
    var uid: Int = 0
    var updatedAt: Int = 0
}

struct HZFindDudfeedItem: HandyJSON {
    var contentId: Int = 0
    var contentType: String?
    var recReason: String?
    var recSrc: String?
    var recTrack: String?
}
