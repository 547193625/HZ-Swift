//
//  HZAdvertCell.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/8.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit

class HZAdvertCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        return titleLabel
    }()
    
    private lazy var subLabel: UILabel = {
        let subLabel = UILabel()
        subLabel.font = UIFont.systemFont(ofSize: 14)
        return subLabel
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAdUI()
    }
    
    func setUpAdUI(){
        self.addSubview(self.imageView)
        self.imageView.image = UIImage(named: "fj.jpg")
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        self.imageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-60)
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.text = "那些事"
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.imageView.snp.bottom)
            make.height.equalTo(30)
        }
        
        self.addSubview(self.subLabel)
        self.subLabel.text = "开年会发年终奖呀领导开年会发年终奖呀"
        self.subLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.height.equalTo(30)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var adModel:HZRecommnedAdvertModel? {
        didSet{
            guard let model = adModel else {
                return
            }
            self.titleLabel.text = model.name
            self.subLabel.text = model.description
        }
    }
    
    
    
}
