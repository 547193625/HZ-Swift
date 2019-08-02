//
//  HZRecommendHeaderCell.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit
import FSPagerView

/// 添加按钮点击代理方法
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
//    var squareList:[HZSquareModel]? {
//        didSet{
//            guard let model = squareList else { return }
//            self.square = model
//            self.gridView.reloadData()
//        }
//    }
//
//    var topBuzzListData:[HZTopBuzzModel]? {
//        didSet{
//            guard let model = topBuzzListData else { return }
//            self.topBuzzList = model
//            self.gridView.reloadData()
//        }
//    }
    
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
