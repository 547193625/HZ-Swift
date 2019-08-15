//
//  HZListenSubscibeController.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/9.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit
import LTScrollView

class HZListenSubscibeController: UIViewController,LTTableViewProtocal {
    
    private lazy var footerView:HZListenFooterView = {
        let view = HZListenFooterView.init(frame: CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 100))
        view.listenFootViewTitle = "➕添加订阅"
        return view
    }()

    private let  HZListenSubscibeCellID = "HZListenSubscibeCell"
    
    private lazy var tableView: UITableView = {
        let  tableView = tableViewConfig(CGRect(x: 0, y: 0, width:LBFMScreenWidth, height: LBFMScreenHeight - 64), self, self, nil)
        tableView.register(HZListenSubscibeCell.self, forCellReuseIdentifier: HZListenSubscibeCellID)
        tableView.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        tableView.tableFooterView = self.footerView
        return tableView
    }()
    
    lazy var viewModel: HZListenSubscibeViewModel = {
        return HZListenSubscibeViewModel()
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

extension HZListenSubscibeController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HZListenSubscibeCell = tableView.dequeueReusableCell(withIdentifier: HZListenSubscibeCellID, for: indexPath) as! HZListenSubscibeCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.albumResults = viewModel.albumResults?[indexPath.row]
        return cell
    }
    
}
