//
//  HZRecommendHeaderCell.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit
import FSPagerView

// 添加按钮点击代理方法
protocol HZRecommendHeaderCellDelegate:NSObjectProtocol {
    func recommendHeaderBtnClick(categoryId:String,title:String,url:String)
    func recommendHeaderBannerClick(url:String)
}

class HZRecommendHeaderCell: UICollectionViewCell {
    private var focus:HZFocusModel?
    private var square:[HZSquareModel]?
    private var topBuzzList:[HZTopBuzzModel]?
    
    weak var delegate : HZRecommendHeaderCellDelegate?
    
    private lazy var pagerView : FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval =  3
        pagerView.isInfinite = true
        pagerView.interitemSpacing = 15
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        return pagerView
    }()
    
    // MARK: - 懒加载九宫格分类按钮
    private lazy  var  gridView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(HZRecommendGridCell.self, forCellWithReuseIdentifier: "HZRecommendGridCell")
        collectionView.register(HZRecommendNewsCell.self, forCellWithReuseIdentifier: "HZRecommendNewsCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 设置布局
        setUpLayOut()
    }
 
    func  setUpLayOut() {
        self.addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(150)
        }
        // 九宫格
        self.addSubview(self.gridView)
        self.gridView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.pagerView.snp.bottom)
            make.height.equalTo(210)
        }
        
        self.pagerView.itemSize =  CGSize.init(width: LBFMScreenWidth - 60, height: 140)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var focusModel:HZFocusModel? {
        didSet{
            guard let model = focusModel else { return }
            self.focus = model
            self.pagerView.reloadData()
        }
    }
    var squareList:[HZSquareModel]? {
        didSet{
            guard let model = squareList else { return }
            self.square = model
            self.gridView.reloadData()
        }
    }

    var topBuzzListData:[HZTopBuzzModel]? {
        didSet{
            guard let model = topBuzzListData else { return }
            self.topBuzzList = model
            self.gridView.reloadData()
        }
    }
    
}

extension HZRecommendHeaderCell:FSPagerViewDelegate,FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.focus?.data?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.setImage(with: URL(string: (self.focus?.data?[index].cover)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let url:String = self.focus?.data?[index].link ?? ""
        delegate?.recommendHeaderBannerClick(url: url)
    }
    
}

extension HZRecommendHeaderCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.square?.count ?? 0
        }else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize.init(width: (LBFMScreenWidth - 5)/5, height:80)
        }else {
            return CGSize.init(width: LBFMScreenWidth, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell:HZRecommendGridCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HZRecommendGridCell", for: indexPath) as! HZRecommendGridCell
            cell.square = self.square?[indexPath.row]
            return cell
        }else{
            let cell:HZRecommendNewsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HZRecommendNewsCell", for: indexPath) as! HZRecommendNewsCell
            cell.topBuzzList = self.topBuzzList
            return cell
        }
    }
    
    
}
