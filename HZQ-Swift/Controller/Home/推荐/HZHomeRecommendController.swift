//
//  HZHomeRecommendController.swift
//  HZQ-Swift
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 huzhiqiang. All rights reserved.
//

import UIKit
import SwiftMessages
class HZHomeRecommendController: UIViewController {
    
    // cell 注册
    private let LBFMRecommendHeaderViewID     = "LBFMRecommendHeaderView"
    private let LBFMRecommendFooterViewID     = "LBFMRecommendFooterView"
    
    // 注册不同的cell
    private let HZRecommendHeaderCellID     = "HZRecommendHeaderCell"
    // 猜你喜欢
    private let HZRecommendGuessLikeCellID  = "HZRecommendGuessLikeCell"
    // 热门有声书
    private let LBFMHotAudiobookCellID        = "LBFMHotAudiobookCell"
    // 广告
    private let LBFMAdvertCellID              = "LBFMAdvertCell"
    // 懒人电台
    private let LBFMOneKeyListenCellID        = "LBFMOneKeyListenCell"
    // 为你推荐
    private let LBFMRecommendForYouCellID     = "LBFMRecommendForYouCell"
    // 推荐直播
    private let LBFMHomeRecommendLiveCellID   = "LBFMHomeRecommendLiveCell"
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view .addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
//        self.collectionView.uHead.beginRefreshing()
        setupLoadData()
    }
    
    func setupLoadData(){
        // 加载数据
        viewModel.updateDataBlock = {[unowned self] in
//            self.collectionView.uHead.endRefreshing()
            // 更新列表数据
            self.collectionView.reloadData()
        }
        
        viewModel.refreshDataSource()
    }

    //    lazy
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        // - 注册头视图和尾视图
//        collection.register(<#T##viewClass: AnyClass?##AnyClass?#>, forSupplementaryViewOfKind: <#T##String#>, withReuseIdentifier: <#T##String#>)
        
        
        // - 注册不同分区cell
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.register(HZRecommendHeaderCell.self, forCellWithReuseIdentifier: HZRecommendHeaderCellID)
        collection.register(HZRecommendGuessLikeCell.self, forCellWithReuseIdentifier: HZRecommendGuessLikeCellID)
        
        return collection
    }()
    
    lazy var viewModel:HZRecommendViewModel = {
       return HZRecommendViewModel()
    }()
}


extension HZHomeRecommendController: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
          return viewModel.numberOfSections(collectionView:collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moduleType = viewModel.homeRecommendList?[indexPath.section].moduleType
        
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" {
            let cell:HZRecommendHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: HZRecommendHeaderCellID, for: indexPath) as! HZRecommendHeaderCell
            cell.focusModel = viewModel.focus
            cell.squareList = viewModel.squareList
            cell.topBuzzListData = viewModel.topBuzzList
            cell.delegate = self
            return cell
        }else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory"{
            // 横式排列布局cell
            let cell:HZRecommendGuessLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: HZRecommendGuessLikeCellID, for: indexPath) as! HZRecommendGuessLikeCell
//            cell.delegate = self
//            cell.recommendListData = viewModel.homeRecommendList?[indexPath.section].list
            return cell
        }else{
            let cell:HZRecommendHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: HZRecommendHeaderCellID, for: indexPath) as! HZRecommendHeaderCell
            cell.focusModel = viewModel.focus
            //            cell.squareList = viewModel.squareList
            //            cell.topBuzzListData = viewModel.topBuzzList
            //            cell.delegate = self
            return cell
        }
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt(section: section)
    }
    // 最小item间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
}

extension HZHomeRecommendController:HZRecommendHeaderCellDelegate{
    func recommendHeaderBannerClick(url: String) {
        let status2 = MessageView.viewFromNib(layout: .statusLine)
        status2.backgroundView.backgroundColor = LBFMButtonColor
        status2.bodyLabel?.textColor = UIColor.white
        status2.configureContent(body: "暂时没有点击功能")
        var status2Config = SwiftMessages.defaultConfig
        status2Config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        status2Config.preferredStatusBarStyle = .lightContent
        SwiftMessages.show(config: status2Config, view: status2)
    }
    
    func recommendHeaderBtnClick(categoryId:String,title:String,url:String){
        if url == "" {
            
        }else{
            let vc = HZWebViewController(url:url)
            vc.title = title
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


