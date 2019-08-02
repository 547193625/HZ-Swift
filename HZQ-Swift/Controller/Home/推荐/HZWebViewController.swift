//
//  HZWebViewController.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit
import WebKit

class HZWebViewController: UIViewController {
    private var url:String = ""
    
    convenience init(url: String = "") {
        self.init()
        self.url = url
    }
    private lazy var webView:WKWebView = {
        let webView = WKWebView(frame: self.view.bounds)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(webView)
        webView.load(URLRequest.init(url: URL.init(string: self.url)!))
    }

}
