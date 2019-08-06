//
//  HZGuessYouLikeCell.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/6.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit

class HZGuessYouLikeCell: UICollectionViewCell {
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    private var subLabel: UILabel = {
        let subLabel = UILabel()
        subLabel.font = UIFont.systemFont(ofSize: 14.0)
        subLabel.textColor = UIColor.gray
        subLabel.numberOfLines = 0
        return subLabel
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setLayout() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
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
    }
    
    var recommendData:HZRecommendListModel?{
        didSet{
            guard let model = recommendData  else {
                return
            }
            if(model.pic != nil) {
                self.imageView.kf.setImage(with: URL(string:model.pic!))
            }
            self.titleLabel.text = model.title
            self.subLabel.text = model.subtitle
            
        }
    }
}
