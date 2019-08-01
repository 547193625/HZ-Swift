//
//  HZHeader.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/1.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//
import UIKit
import Foundation
import Kingfisher
import SnapKit
import SwiftyJSON
import HandyJSON
import SwiftMessages


let LBFMScreenWidth = UIScreen.main.bounds.size.width
let LBFMScreenHeight = UIScreen.main.bounds.size.height

let LBFMButtonColor = UIColor(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let LBFMDownColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)


// iphone X
let isIphoneX = LBFMScreenHeight == 812 ? true : false
// LBFMNavBarHeight
let LBFMNavBarHeight : CGFloat = isIphoneX ? 88 : 64
// LBFMTabBarHeight
let LBFMTabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49
