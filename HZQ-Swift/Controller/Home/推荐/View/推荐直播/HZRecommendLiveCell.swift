//
//  HZRecommendLiveCell.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/9.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit

class HZRecommendLiveCell: UICollectionViewCell {
    // 图片
    private var imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // 标题
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    // 子标题
    private var subLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    
    // 分类名称
    private var categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.font = UIFont.systemFont(ofSize: 12)
        categoryLabel.textColor = UIColor.white
        categoryLabel.backgroundColor = UIColor.orange
        return categoryLabel
    }()
    
    // 播放器动画效果
    private var replicatorLayer:ReplicatorLayer = {
        let layer = ReplicatorLayer.init(frame: CGRect(x: 0, y: 0, width: 2, height: 15))
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLiveUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  setLiveUI() {
        self.addSubview(self.imageView)
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 8
        self.imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        self.imageView.addSubview(self.categoryLabel)
        self.categoryLabel.layer.masksToBounds = true
        self.categoryLabel.layer.cornerRadius = 4
        self.categoryLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.subLabel)
        self.subLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
        
        self.imageView.addSubview(self.replicatorLayer)
        self.replicatorLayer.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(20)
            make.height.equalTo(10)
        }
    }
    
    var recommendliveData:HZLiveModel? {
        didSet{
            guard let model = recommendliveData  else {
                return
            }
            if model.coverMiddle != nil {
                self.imageView.kf.setImage(with: URL(string: model.coverMiddle!))
            }
            self.titleLabel.text = model.nickname
            self.subLabel.text = model.name
            self.categoryLabel.text = model.categoryName
        }
    }
    
    var liveData:HZLiveModel? {
        didSet{
            guard let model = liveData  else {
                return
            }
            if model.coverMiddle != nil {
                self.imageView.kf.setImage(with: URL(string: model.coverMiddle!))
            }
            self.titleLabel.text = model.nickname
            self.subLabel.text = model.name
            self.categoryLabel.text = model.categoryName
        }
    }
    
    
}
