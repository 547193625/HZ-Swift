//
//  HZFindHeaderView.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/14.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit

class HZFindHeaderView: UIView {
    let dataArray = ["电子书城","全民朗读","大咖主播","活动","直播微课","听单","游戏中心","边听变看","商城","0元购"]
    private lazy var collectionView : UICollectionView = {
        let  layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (LBFMScreenWidth - 30)/5, height: 90)
        let collectionView = UICollectionView.init(frame: CGRect(x: 15, y: 0, width: LBFMScreenWidth - 30, height: 180), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(HZFindCell.self, forCellWithReuseIdentifier:"HZFindCellID")
        return collectionView
        
    }()
}


extension HZFindHeaderView : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HZFindCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HZFindCellID", for: indexPath) as! HZFindCell
        cell.dataString = self.dataArray[indexPath.row]
    }
    
    
}
