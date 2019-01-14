//
//  LYResultController.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/27.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit

class LYResultController: LYBaseController,UITableViewDelegate,UITableViewDataSource {
    var allCurrenDataArray:Array = [Any]()
    var allSpeedInfoArray:Array = [Any]()

    lazy var resultTableView = UITableView(frame: CGRect(x: 15, y: 10, width: Main_Screen_Width-30, height: Main_Screen_Height-NaviBarHeight-SafeBottomMargin-10-50-40), style: .grouped)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gaintAllListArray()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButton.isHidden = true
        self.navigationItem.title = "历史记录"
        self.rightView.isHidden = false
        self.resultTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.resultTableView.showsVerticalScrollIndicator = false
        self.resultTableView.delegate = self
        self.resultTableView.dataSource = self
        self.resultTableView.backgroundColor = YCColorGray
        //注册cell重用
        self.resultTableView .register(LYResultCell.self, forCellReuseIdentifier:"ResultCellIdentifier")
        self.view.addSubview(resultTableView)
        /** 升级到高级版 */
        self.view.addSubview(self.updateView)
        self.updateView.updateBlock = {() in
            /** 升级到高级版 */
            let buyMemVC = LYBuyMemController()
            buyMemVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(buyMemVC, animated: true)
        }
        //空数据页
        self.view.addSubview(self.notDateLable)
    }
    //MARK:===========UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return allSpeedInfoArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionNum:NSArray = allSpeedInfoArray[section] as! NSArray
        return sectionNum.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = LYResultHeadView()
        let sectionArray:NSArray = allCurrenDataArray[section] as! NSArray
        headView.dateTitlelable.text = sectionArray[0] as? String
        return headView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView = UIView()
        /** 广告位 */
        let adboadView = GADBannerView()
        adboadView.layer.masksToBounds = true
        adboadView.isUserInteractionEnabled = true
        adboadView.layer.cornerRadius = 5
        adboadView.adUnitID = LYDetailADId;
        adboadView.rootViewController = self;
        adboadView.load(GADRequest())
        adboadView.frame = CGRect(x: 0, y: 0, width: Main_Screen_Width-30, height: 70)
        footView .addSubview(adboadView)
        
        return footView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ResultCellIdentifier") as! LYResultCell
        cell.selectionStyle = .none
        let sectionNum:NSArray = allSpeedInfoArray[indexPath.section] as! NSArray
        let infoModel:LYSpeedInfo = sectionNum[indexPath.row] as! LYSpeedInfo
        cell.gaintInfoModel(model: infoModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /** 跳转到详情页 */
        let detailVC = LYResultDetailController()
        let sectionNum:NSArray = allSpeedInfoArray[indexPath.section] as! NSArray
        let infoModel:LYSpeedInfo = sectionNum[indexPath.row] as! LYSpeedInfo
        let speedModel = LYHomeModel()
        speedModel.isWifi = infoModel.isWifi
        speedModel.currenDate = infoModel.currenDate
        speedModel.currenTime = infoModel.currenTime
        speedModel.delay = infoModel.delayeSpeed
        speedModel.downSpeed = infoModel.downSpeed
        speedModel.upSpeed = infoModel.upSpeed
        speedModel.currenWifiName = infoModel.currenWifiName
        detailVC.model = speedModel
        detailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    //MARK:=========清除列表
    @objc override func clearButtonClick(){
        if self.allCurrenDataArray.count==0 {
            return
        }
        let alertController = UIAlertController(title: "提示", message: "确定要清空测速历史吗?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil);
        let okAction = UIAlertAction(title: "确定", style: .default) { (action) in
            LYSpeedInfoManager.shared.cancleAllLocalData()
            self.gaintAllListArray()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    lazy var updateView:LYUpgradeView = {
        let  updateView = LYUpgradeView(frame: CGRect(x: 0, y: Main_Screen_Height-40-kTabBarHeight-NaviBarHeight, width: Main_Screen_Width, height: 40))
        return updateView
    }()
    
    lazy var notDateLable:UILabel = {
        let  notDateLable = UILabel(frame: CGRect(x: 0, y: Main_Screen_Height/2-100, width: Main_Screen_Width, height: 50))
        notDateLable.textColor = YCColorWhite
        notDateLable.font = YC_FONT_PFSC_Medium(20)
        notDateLable.textAlignment = NSTextAlignment.center
        notDateLable.text = "您还没有任何测速结果呦!"
        notDateLable.isHidden = true
        return notDateLable
    }()
    
    //MARK:=========获取本地数据
    func gaintAllListArray() {
        let allListArray:NSArray = LYSpeedInfoManager.shared.searchAllLocalListData()! as NSArray
        /** 获取本地日期数据 */
        allCurrenDataArray.removeAll()
        allSpeedInfoArray.removeAll()
        var tempArray:Array = [Any]()
        for i in 0..<allListArray.count {
            let info:LYSpeedInfo = allListArray[i] as! LYSpeedInfo
            tempArray.append(info.currenDate as Any)
        }
        let groupManeget = LYArrayGroupManager()
        allCurrenDataArray = groupManeget.gaintArray(tempArray) as! [Any]
        var allCount = 0
        for i in 0..<allCurrenDataArray.count {
            let sectionArray:NSArray = allCurrenDataArray[i] as! NSArray
            var infoArray:Array = [Any]()
            for j in 0..<sectionArray.count {
                allCount += 1
                let speedInfo:LYSpeedInfo = allListArray[allCount-1] as! LYSpeedInfo
                infoArray.append(speedInfo)
            }
            allSpeedInfoArray.append(infoArray)
            print("查询本地日期数据=======%@",allSpeedInfoArray);
        }
        if allCurrenDataArray.count==0 {
            self.notDateLable.isHidden = false
        }else{
            self.notDateLable.isHidden = true
        }
        self.resultTableView.reloadData()
    }
}
