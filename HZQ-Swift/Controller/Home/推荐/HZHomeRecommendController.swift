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
    
    // 穿插的广告数据
    private var recommnedAdvertList:[HZRecommnedAdvertModel]?
    // cell 注册
    private let HZRecommendHeaderViewID     = "HZRecommendHeaderView"
    private let LBFMRecommendFooterViewID     = "LBFMRecommendFooterView"
    
    // 注册不同的cell
    private let HZRecommendHeaderCellID     = "HZRecommendHeaderCell"
    // 猜你喜欢
    private let HZRecommendGuessLikeCellID  = "HZRecommendGuessLikeCell"
    // 热门有声书
    private let HZHotAudioBooMainCellID        = "HZHotAudioBooMainCell"
    // 广告
    private let HZAdvertCellID              = "HZAdvertCell"
    // 懒人电台
    private let HZOneKeyListenCellID        = "HZMainOneKeyListenCell"
    // 为你推荐
    private let LBFMRecommendForYouCellID     = "LBFMRecommendForYouCell"
    // 推荐直播
    private let HZHomeRecommendLiveCellID   = "HZHomeRecommendLiveCell"
    
  
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
        collection.register(HZRecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HZRecommendHeaderViewID)
        
        
        // - 注册不同分区cell
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.register(HZRecommendHeaderCell.self, forCellWithReuseIdentifier: HZRecommendHeaderCellID)
        collection.register(HZRecommendGuessLikeCell.self, forCellWithReuseIdentifier: HZRecommendGuessLikeCellID)
        collection.register(HZHotAudioBooMainCell.self, forCellWithReuseIdentifier: HZHotAudioBooMainCellID)
        collection.register(HZAdvertCell.self, forCellWithReuseIdentifier: HZAdvertCellID)
        collection.register(HZMainOneKeyListenCell.self, forCellWithReuseIdentifier: HZOneKeyListenCellID)
        collection.register(HZHomeRecommendLiveCell.self, forCellWithReuseIdentifier: HZHomeRecommendLiveCellID)
        
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
        
        print("moduleType___",moduleType!)
        
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
            cell.delegate = self
            cell.recommendListData = viewModel.homeRecommendList?[indexPath.section].list
            return cell
        }else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore"{
            // 竖式排列布局cell
            let cell:HZHotAudioBooMainCell = collectionView.dequeueReusableCell(withReuseIdentifier: HZHotAudioBooMainCellID, for: indexPath) as! HZHotAudioBooMainCell
            cell.delegate = self
            cell.recommendListData = viewModel.homeRecommendList?[indexPath.section].list
            return cell
        }else if moduleType == "ad" {
            let cell:HZAdvertCell = collectionView.dequeueReusableCell(withReuseIdentifier: HZAdvertCellID, for: indexPath) as! HZAdvertCell
            if indexPath.section == 7 {
                cell.adModel = self.recommnedAdvertList?[0]
            }else if indexPath.section == 13 {
                cell.adModel = self.recommnedAdvertList?[1]
            }
            return cell
        }else if moduleType == "oneKeyListen" {
            let cell:HZMainOneKeyListenCell = collectionView.dequeueReusableCell(withReuseIdentifier: HZOneKeyListenCellID, for: indexPath) as! HZMainOneKeyListenCell
            cell.oneKeyListenList = viewModel.oneKeyListenList
            return cell
        }else if moduleType == "live" {
            let cell:HZHomeRecommendLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: HZHomeRecommendLiveCellID, for: indexPath) as! HZHomeRecommendLiveCell
            cell.liveList = viewModel.liveList
            return cell
        }else{
            let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return viewModel.referenceSizeForFooterInSection(section: section)
//    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let moduleType = viewModel.homeRecommendList?[indexPath.section].moduleType
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView : HZRecommendHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HZRecommendHeaderViewID, for: indexPath) as! HZRecommendHeaderView
            headerView.homeRecommendList = viewModel.homeRecommendList?[indexPath.section]
            // 分区头右边更多按钮点击跳转
            headerView.headerMoreBtnClick = {[weak self]() in
                if moduleType == "guessYouLike"{
//                    let vc = LBFMHomeGuessYouLikeMoreController()
//                    self?.navigationController?.pushViewController(vc, animated: true)
                }else if moduleType == "paidCategory" {
//                    let vc = LBFMHomeVIPController(isRecommendPush:true)
//                    vc.title = "精品"
//                    self?.navigationController?.pushViewController(vc, animated: true)
                }else if moduleType == "live"{
//                    let vc = LBFMHomeLiveController()
//                    vc.title = "直播"
//                    self?.navigationController?.pushViewController(vc, animated: true)
                }else {
//                    guard let categoryId = self?.viewModel.homeRecommendList?[indexPath.section].target?.categoryId else {return}
//                    if categoryId != 0 {
//                        let vc = LBFMClassifySubMenuController(categoryId:categoryId,isVipPush:false)
//                        vc.title = self?.viewModel.homeRecommendList?[indexPath.section].title
//                        self?.navigationController?.pushViewController(vc, animated: true)
//                    }
                }
            }
            return headerView
        }else{
            
        }
//        else if kind == UICollectionView.elementKindSectionFooter {
//            let footerView : LBFMRecommendFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LBFMRecommendFooterViewID, for: indexPath) as! LBFMRecommendFooterView
//            return footerView
//        }
        return UICollectionReusableView()
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

extension HZHomeRecommendController:HZRecommendGuessLikeCellDelegate{
    func recommendGuessLikeCellItemClick(model: HZRecommendListModel) {
        print("点击猜你喜欢")
    }
}

extension HZHomeRecommendController:HZHotAudiobookCellDelegate{
    func hotAudiobookCellItemClick(model: HZRecommendListModel) {
        print("点击热门有声书")
    }
    
    
}

