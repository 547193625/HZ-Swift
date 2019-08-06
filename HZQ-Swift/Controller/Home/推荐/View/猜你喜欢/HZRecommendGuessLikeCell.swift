//
//  HZRecommendGuessLikeCell.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/6.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

protocol HZRecommendGuessLikeCellDelegate:NSObjectProtocol {
    func recommendGuessLikeCellItemClick(model:HZRecommendListModel)
}
class HZRecommendGuessLikeCell: UICollectionViewCell {
    
    weak var delegate : HZRecommendGuessLikeCellDelegate?
    
    private var recommendList:[HZRecommendListModel]?
    
    private let HZGuessYouLikeCellID = "HZGuessYouLikeCell"
    
    private lazy var changeBtn: UIButton = {
       let button = UIButton.init(type:.custom)
        button.setTitle("换一批", for: .normal)
        button.setTitleColor(LBFMButtonColor, for: .normal)
        button.backgroundColor = UIColor.init(red: 254/255.0, green: 232/255.0, blue: 227/255.0, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(upDataBtnClick(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(HZGuessYouLikeCell.self, forCellWithReuseIdentifier: HZGuessYouLikeCellID)
        return collectionView
    }()
    
    
    @objc func upDataBtnClick(button:UIButton){
        // 首页推荐接口请求
        HZRecommendProvider.request(.changeGuessYouLikeList) { result in
            if case let .success(response) = result {
                // 解析数据
                let  data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HZRecommendListModel>.deserializeModelArrayFrom(json: json["list"].description) {
                    self.recommendList = mappedObject as? [HZRecommendListModel]
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
}

extension HZRecommendGuessLikeCell:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommendList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HZGuessYouLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: HZGuessYouLikeCellID, for: indexPath) as! HZGuessYouLikeCell
        cell.recommendData = self.recommendList?[indexPath.row]
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.recommendGuessLikeCellItemClick(model: (self.recommendList?[indexPath.row])!)
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:(LBFMScreenWidth - 55) / 3,height:180)
    }
}
