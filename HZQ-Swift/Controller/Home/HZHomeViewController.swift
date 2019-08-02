//
//  HZHomeViewController.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/1.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit
import DNSPageView
class HZHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupPageStyle()

    }
    
    
    func setupPageStyle() {
        let style = DNSPageStyle()
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = LBFMButtonColor
        style.bottomLineHeight = 2
        
        let titles = ["推荐","分类","VIP","直播","广播"]
        let viewControllers:[UIViewController] = [HZHomeRecommendController(),HZHomeClassifyViewController(),HZHomeVIPViewController(),HZHomeLiveViewController(),HZHomeBroadcastViewController()]
        
        for vc in viewControllers {
            self.addChild(vc)
        }
        
        let pageView = DNSPageView(frame: CGRect(x: 0, y: LBFMNavBarHeight, width: LBFMScreenWidth, height: LBFMScreenHeight - LBFMNavBarHeight - 44), style: style, titles: titles, childViewControllers: viewControllers)
        pageView.contentView.backgroundColor = UIColor.red
        view.addSubview(pageView)
        
        
    }
}
