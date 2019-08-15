//
//  HZListenFooterView.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/12.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit

/// 添加按钮点击代理方法
protocol HZListenFooterViewDelegate:NSObjectProtocol {
    func listenFooterAddBtnClick()
}
// 订阅和一键听底部添加按钮
class HZListenFooterView: UIView {
    weak var delegate : HZListenFooterViewDelegate?
    
    private var addButton:UIButton = {
        let addButton = UIButton.init(type: .custom)
        addButton.setTitleColor(UIColor.black, for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        addButton.backgroundColor = UIColor.white
        addButton.addTarget(self, action: #selector(addButtonClick), for:.touchUpInside)
        return addButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpFootViewLayout()
    }
    

    func setUpFootViewLayout(){
        self.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.centerX.equalToSuperview()
        }
        addButton.layer.masksToBounds = true
        addButton.layer.cornerRadius = 20
    }
    
    var listenFootViewTitle:String? {
        didSet{
            addButton.setTitle(listenFootViewTitle, for: .normal)
        }
    }
    
    @objc func addButtonClick(){
        delegate?.listenFooterAddBtnClick()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
