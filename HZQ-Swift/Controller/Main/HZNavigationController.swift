//
//  HZNavigationController.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/1.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit

class HZNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBarAppearence()
    }
    
    func setupNavBarAppearence()  {
          // 设置导航栏默认的背景颜色
        WRNavigationBar.defaultNavBarTitleColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        // 设置导航栏所有按钮的
        WRNavigationBar.defaultNavBarTintColor = LBFMButtonColor
        WRNavigationBar.defaultNavBarTitleColor = UIColor.black
        // 统一设置导航栏样式
        //        WRNavigationBar.defaultStatusBarStyle = .lightContent
        // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
        WRNavigationBar.defaultShadowImageHidden = true
        
    }
}

extension HZNavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
