//
//  HZRecommendHeaderView.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/7.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit

// 闭包
typealias HZHeaderMoreBtnClick = () ->Void

class HZRecommendHeaderView: UICollectionReusableView {
    var  headerMoreBtnClick : HZHeaderMoreBtnClick?
    
    // 标题
    private var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        return titleLabel
    }()
    
    // 副标题
    private var subLabel:UILabel = {
        let  subLabel = UILabel.init()
        subLabel.font = UIFont.systemFont(ofSize: 15)
        subLabel.textColor = UIColor.lightGray
        subLabel.textAlignment = .right
        return subLabel
    }()
    
    // 更多
    
    private var  moreButton:UIButton = {
       let moreButton = UIButton.init(type: .custom)
        moreButton.setTitle("更多 >", for: .normal)
        moreButton.setTitleColor(UIColor.gray, for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        moreButton.addTarget(self, action: #selector(moreButtonClick(moreButton:)), for: .touchUpInside)
        return moreButton
    }()
    
    @objc func moreButtonClick(moreButton:UIButton) {
        // 闭包回调
        guard let headerMoreBtnClick = headerMoreBtnClick else {
            return
        }
        headerMoreBtnClick()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHeaderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func  setUpHeaderView(){
        self.addSubview(self.titleLabel)
        self.titleLabel.text = "猜你喜欢"
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        self.addSubview(self.subLabel)
        subLabel.textColor = UIColor.red
        self.subLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.right)
            make.height.top.equalTo(self.titleLabel)
            make.right.equalToSuperview().offset(-100)
        }
        self.addSubview(self.moreButton)
        self.moreButton.snp.makeConstraints { (make) in
            make.right.equalTo(15)
            make.top.equalTo(15)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
    
    var homeRecommendList:HZRecommendModel? {
        didSet{
            guard let model = homeRecommendList else {
                return
            }
            if (model.title != nil) {
                self.titleLabel.text = model.title
            }else{
                self.titleLabel.text = "猜你喜欢"
            }
        }
    }
    
}
