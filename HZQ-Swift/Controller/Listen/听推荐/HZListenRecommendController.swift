//
//  HZListenRecommendController.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/9.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit
import LTScrollView

class HZListenRecommendController: UIViewController,LTTableViewProtocal {
    private let HZListenRecommendCellID = "HZListenRecommendCell"
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:LBFMScreenWidth, height: LBFMScreenHeight - LBFMTabBarHeight - LBFMNavBarHeight), self, self, nil)
        tableView.register(HZListenRecommendCell.self, forCellReuseIdentifier: HZListenRecommendCellID)
        tableView.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        return tableView
    }()
    
    lazy var viewModel: HZListenRecommendViewModel = {
        return HZListenRecommendViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        // 加载数据
        setupLoadData()
    }
    
    func setupLoadData() {
        // 加载数据
        viewModel.upDataBlock = { [unowned self] in
            // 更新列表数据
            self.tableView.reloadData()
        }
        viewModel.refreshDataSource()
    }
}

extension HZListenRecommendController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HZListenRecommendCell = tableView.dequeueReusableCell(withIdentifier: HZListenRecommendCellID, for: indexPath) as! HZListenRecommendCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.albums = viewModel.albums?[indexPath.row]
        return cell
    }
}
