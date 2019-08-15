//
//  HZListenChannelController.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/9.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit
import LTScrollView

class HZListenChannelController: UIViewController, LTTableViewProtocal{
    // - footerView
    private lazy var footerView:HZListenFooterView = {
        let view = HZListenFooterView.init(frame: CGRect(x:0, y:0, width:LBFMScreenWidth, height:100))
        view.listenFootViewTitle = "➕添加频道"
        view.delegate = self
        return view
    }()
    
    private let HZListenChannelCellID = "HZListenChannelCell"
    
    private lazy var tableView:UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:LBFMScreenWidth, height: LBFMScreenHeight - 64), self, self, nil)
        tableView.register(HZListenChannelCell.self, forCellReuseIdentifier: HZListenChannelCellID)
        tableView.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = self.footerView
        return tableView
    }()
    
    
    lazy var viewModel: HZListenChannelViewModel = {
        return HZListenChannelViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view .addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }else{
            automaticallyAdjustsScrollViewInsets = false
        }
        // 请求数据
        setupLoadData()
    }
    
    func setupLoadData() {
        // 加载数据
         viewModel.refreshDataSource()
        
        viewModel.upDataBlock = { [unowned self] in
            // 更新列表数据
            self.tableView.reloadData()
        }
    }
}

extension HZListenChannelController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HZListenChannelCell = tableView.dequeueReusableCell(withIdentifier: HZListenChannelCellID, for: indexPath) as! HZListenChannelCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        cell.channelResults = viewModel.channelResults?[indexPath.row]
        return cell
    }
}

// - 底部添加频道按钮点击delegate
extension HZListenChannelController : HZListenFooterViewDelegate {
    func listenFooterAddBtnClick() {
//        let vc = HZListenMoreChannelController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
