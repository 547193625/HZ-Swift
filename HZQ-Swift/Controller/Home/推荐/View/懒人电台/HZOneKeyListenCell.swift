//
//  HZOneKeyListenCell.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/8.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit

class HZOneKeyListenCell: UICollectionViewCell {
    private lazy var imageView : UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = NSTextAlignment.center
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setOneKeyUI()
    }
    
    func setOneKeyUI() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(70)
            make.centerX.equalToSuperview()
            make.top.equalTo(15)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var oneKeyListen:HZOneKeyListenModel? {
        didSet {
            guard let model = oneKeyListen else { return }
            if (model.coverRound != nil) {
                self.imageView.kf.setImage(with: URL(string: model.coverRound!))
            }
            self.titleLabel.text = "2132132131313123"
        }
    }
}
