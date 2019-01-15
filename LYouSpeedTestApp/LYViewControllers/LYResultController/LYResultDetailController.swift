//
//  LYResultDetailController.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/2.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

class LYResultDetailController: LYBaseController {
    var isFromHome = false
    
    var model = LYHomeModel()
    var shareRightView:UIButton = UIButton()
    let shareButton =   UIButton(type: .custom)
    let adboadView = GADBannerView()  /** 广告版位 */

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = model.currenWifiName
        backButton.frame.origin.y = 12
        /** 主页面 */
        let mainScrollView = UIScrollView()
        mainScrollView.bounces = false
        mainScrollView.showsHorizontalScrollIndicator = false //不显示水平拖地的条
        mainScrollView.showsVerticalScrollIndicator = false //不显示垂直拖动的条
        mainScrollView.backgroundColor = YCColorLightGray
        self.view.addSubview(mainScrollView)
        mainScrollView.contentSize = CGSize(width: Main_Screen_Width, height: 667+500)
        mainScrollView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(0);
            make.height.equalTo(Main_Screen_Height);
        }
        /** 头部 */
        let headView = LYDetailHeadView()
        mainScrollView.addSubview(headView)
        headView.snp.makeConstraints { (make) in
            make.left.equalTo(0);
            make.width.equalTo(Main_Screen_Width)
            make.top.equalTo(mainScrollView).offset(0);
            make.height.equalTo(320);
        }
        if !isFromHome {
            headView.discritlable.isHidden = true
            headView.restartButton.isHidden = true
            headView.snp.updateConstraints { (make) in
                make.height.equalTo(240);
            }
            mainScrollView.contentSize = CGSize(width: Main_Screen_Width, height: 667+420)
        }
        headView.restartButtonBlock = {()in
            self.navigationController?.popViewController(animated: true)
        }
        headView.gaintInfoModel(infoModel: self.model)
        /** 网速排名 */
        let contentView = LYDetailContentView()
        mainScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.equalTo(0);
            make.width.equalTo(Main_Screen_Width)
            make.top.equalTo(headView.snp.bottom).offset(15);
            make.height.equalTo(320);
        }
        contentView.gaintInfoModel(infoModel: self.model)
        contentView.speedButtonBlock = {()in
            self.iOSsystemShare()
        }
        /** 更多详情 */
        let moreView = LYDetailMoreView()
        mainScrollView.addSubview(moreView)
        moreView.snp.makeConstraints { (make) in
            make.left.equalTo(0);
            make.width.equalTo(Main_Screen_Width)
            make.top.equalTo(contentView.snp.bottom).offset(15);
            make.height.equalTo(270);
        }
        moreView.gaintInfoModel(infoModel: self.model)
        /** 测试结果 */
        let resultView = LYDetailTestResultView()
        mainScrollView.addSubview(resultView)
        resultView.snp.makeConstraints { (make) in
            make.left.equalTo(0);
            make.width.equalTo(Main_Screen_Width)
            make.top.equalTo(moreView.snp.bottom).offset(15);
            make.height.equalTo(85);
        }
        resultView.resultButtonBlock = {()in
            resultView.removeFromSuperview()
            if self.isFromHome {
                mainScrollView.contentSize = CGSize(width: Main_Screen_Width, height: 667+410)
            }else{
                mainScrollView.contentSize = CGSize(width: Main_Screen_Width, height: 667+330)
            }
            EasyShowTextView.showText("反馈成功")
        }
       /** 广告位 */
        self.view.addSubview(self.adboadView)
        self.adboadView.snp.makeConstraints { (make) in
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.bottom.equalTo(0);
            make.height.equalTo(55);
        }
        self.adboadView.adUnitID = LYDetailADId;
        self.adboadView.rootViewController = self;
        self.adboadView.load(GADRequest())
    }

    //分享按钮点击响应
    @objc func shareButtonClick(){
        iOSsystemShare()
    }
    //MARK:============iOS系统分享=============
    func iOSsystemShare() {
        let textToShare = "我正在使用全网测"
        let imageToShare = UIImage(named: "shareImage")
        let urlToShare = URL(string: "http://itunes.apple.com/lookup?id=\(APPSTOREID)")
        let activityItems = [textToShare, imageToShare as Any, urlToShare as Any] as [Any]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
//        activityVC.excludedActivityTypes = [.print, .copyToPasteboard, .assignToContact, .saveToCameraRoll]
        present(activityVC, animated: true)
        activityVC.completionWithItemsHandler = { activityType, completed, returnedItems, activityError in
            if completed {
                print("completed")
            } else {
                print("cancled")
            }
        }
    }
}
