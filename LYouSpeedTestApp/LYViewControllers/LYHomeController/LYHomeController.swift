//
//  LYHomeController.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/27.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit
import Alamofire

class LYHomeController: LYBaseController {
    var currenDownMeaurNet = LYDownFileNetTools()
    var currenUpMeaurNet = LYUpLoadFileNetTools()
    var scaleImageView = UIImageView()

    let speedModel = LYHomeModel()
    let headView = LYHomeHeadView()
    var currenProgressView = LYCycleProgressView()
    let leftArrow = UIImageView()
    let rightArrow = UIImageView()
    var pingServices = STDPingServices()
    var YansImage = UIImageView()
    var YansLable = UILabel()
    var YansDanwLable = UILabel()
    
    var downImage = UIImageView()
    var downLable = UILabel()
    var downDanwLable = UILabel()
    
    var upLoadImage = UIImageView()
    var upLoadLable = UILabel()
    var upLoadDanwLable = UILabel()
    
    let startButton = UIButton()
    let testSpeedView = LYSpeedProgresView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startButton.isHidden = false
        testSpeedView.isHidden = true
        self.currenProgressView.progress = 0.0
        scaleImageView.image = UIImage(named: "scaleDefaleImage")
        if ISSELKBPS()=="no"{
            self.currenProgressView.countJump.text = String(format: "0\nMbps")
            if self.speedModel.downOringSpeed==nil{
            }else{
                self.downLable.text = self.speedModel.downSpeed
                self.downDanwLable.text = "Mbps"
                self.upLoadLable.text = self.speedModel.upSpeed
                self.upLoadDanwLable.text = "Mbps"
            }
        }else{
            self.currenProgressView.countJump.text = String(format: "0\nKb/s")
            if self.speedModel.downOringSpeed==nil{
            }else{
                let kbDownSpeedDate = "\(QBTools.formatKbFileSize(UInt64(self.speedModel.downOringSpeed!))!)"
                let kbUpSpeedDate = "\(QBTools.formatKbFileSize(UInt64(self.speedModel.upOringSpeed!))!)"
                let speedDownStr:Array = kbDownSpeedDate.components(separatedBy:"/")
                self.downLable.text = "\(speedDownStr[0])"
                self.downDanwLable.text = "\(speedDownStr[1])/S"
                let speedUpStr:Array = kbUpSpeedDate.components(separatedBy:"/")
                self.upLoadLable.text = "\(speedUpStr[0])"
                self.upLoadDanwLable.text = "\(speedUpStr[1])/S"
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TX SPEED"
        self.backButton.isHidden = true
        self.view.addSubview(headView)
        headView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalToSuperview()
            make.height.equalTo(kWidth(R: 180))
        }
        /** 创建刻度盘 */
        scaleImageView.frame = CGRect(x: 0, y: 0, width: Main_Screen_Width/3*2.5, height: Main_Screen_Width/3*2.4)
        scaleImageView.image = UIImage(named: "scaleDefaleImage")
        scaleImageView.center.x = self.view.center.x
        scaleImageView.center.y = self.view.center.y-55
        self.view.addSubview(scaleImageView)
        /** 创建进度条 */
        let progressView = LYCycleProgressView(frame: CGRect(x: 0, y: 0, width: Main_Screen_Width/3*2, height: Main_Screen_Width/3*2))
        progressView.center.x = self.view.center.x
        progressView.center.y = self.view.center.y-50
        progressView.progress = 0.0
        self.view.addSubview(progressView)
        currenProgressView = progressView

        /** 开始按钮 */
        self.view.addSubview(startButton)
        startButton.layer.masksToBounds = true
        startButton.layer.cornerRadius = 40/2
        startButton.setTitle("开始", for: .normal)
        startButton.titleLabel?.font = YC_FONT_PFSC_Medium(15)
        startButton.backgroundColor = YCColorStanBlue
        startButton.frame = CGRect(x: 70, y: progressView.frame.origin.y+Main_Screen_Width/3*2+40, width: Main_Screen_Width-140, height: 40)
        startButton.addTarget(self, action: #selector(startButtonClick), for: .touchUpInside)
        /** 测速中进度条 */
        self.view.addSubview(testSpeedView)
        testSpeedView.isHidden = true
        testSpeedView.frame = CGRect(x: 0, y: progressView.frame.origin.y+Main_Screen_Width/3*2+20, width: Main_Screen_Width, height: 50)
        /** 升级到高级版 */
        self.view.addSubview(self.updateView)
        self.updateView.updateBlock = {() in
            /** 升级到高级版 */
            let tipsView = LYFreeTipsView()
            tipsView.frame = CGRect(x: 0, y: 0, width: Main_Screen_Width, height: Main_Screen_Height)
            let window: UIWindow? = UIApplication.shared.keyWindow
            window!.addSubview(tipsView)
            tipsView.closeBlock = {() in
                tipsView.removeFromSuperview()
            }
            tipsView.selUpdateBlock = {() in
                tipsView.removeFromSuperview()
                let buyMemVC = LYBuyMemController()
                buyMemVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(buyMemVC, animated: true)
            }
//            let buyMemVC = LYBuyMemController()
//            buyMemVC.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(buyMemVC, animated: true)
        }
        /** 监听网络变化 */
        currentNetReachability(view:progressView)
        /** 监听上传下载速度变化 */
        listenNetworkSpeed()
    }
    
    @objc private func startButtonClick()  {
        if IPADRESS().count==0 {
            return
        }
    /** 测试延时 */
    self.currenProgressView.progress = 0.0
    self.YansImage = self.headView.viewWithTag(100) as! UIImageView
    self.YansLable = self.headView.viewWithTag(1000) as! UILabel
    self.YansDanwLable = self.headView.viewWithTag(10000) as! UILabel
    self.YansImage.isHidden = false
    self.YansLable.isHidden = true
    self.YansDanwLable.isHidden = true

    self.downImage = self.headView.viewWithTag(101) as! UIImageView
    self.downLable = self.headView.viewWithTag(1001) as! UILabel
    self.downDanwLable = self.headView.viewWithTag(10001) as! UILabel
    self.downImage.isHidden = false
    self.downImage.image = UIImage(named: "im_download_wait")
    self.downLable.isHidden = true
    self.downDanwLable.isHidden = true

    self.upLoadImage = self.headView.viewWithTag(102) as! UIImageView
    self.upLoadLable = self.headView.viewWithTag(1002) as! UILabel
    self.upLoadDanwLable = self.headView.viewWithTag(10002) as! UILabel
    self.upLoadImage.isHidden = false
    self.upLoadImage.image = UIImage(named: "im_upload_wait")
    self.upLoadLable.isHidden = true
    self.upLoadDanwLable.isHidden = true

    let opts: UIView.AnimationOptions = [.autoreverse , .repeat]
    UIView.animate(withDuration: 0.5, delay: 0, options: opts, animations: {
        self.YansImage.alpha = 0
    }, completion: { _ in
        self.YansImage.alpha = 1
    })
    self.pingServices = STDPingServices.startPingAddress(IPADRESS(), callbackHandler: {pingItem, pingItems in
        print("网络延迟======\(String(describing: pingItem?.timeMilliseconds))")
        if pingItem?.status != STDPingStatus.finished {
            if pingItem?.timeMilliseconds != 0{
                self.YansImage.isHidden = true
                self.YansLable.isHidden = false
                self.YansDanwLable.isHidden = false
                self.YansLable.text = String.init(format:"%.1f",pingItem!.timeMilliseconds)
                self.speedModel.delay = self.YansLable.text
                self.YansImage.layer.removeAllAnimations()
                /** 测试下载宽带 */
                self.testDownloadSpeed()
            }
            if pingItem?.status == STDPingStatus.finished{
                self.YansLable.text = String.init(format:"5.0")
            }
        }
    })
}
    //MARK:=======测试下载宽带
    func testDownloadSpeed(){
        /** 显示测试进度 */
        startButton.isHidden = true
        testSpeedView.isHidden = false
        testSpeedView.leftProgresView.image = UIImage(named: "leftDownProgress")
        testSpeedView.progressView.image = UIImage(named: "downLoadProgress")
        testSpeedView.titlelabel.text = "正在测试下载速度"
        scaleImageView.image = UIImage(named: "scaleDownImage")

        self.downImage = self.headView.viewWithTag(101) as! UIImageView
        self.downLable = self.headView.viewWithTag(1001) as! UILabel
        self.downDanwLable = self.headView.viewWithTag(10001) as! UILabel
        self.downImage.isHidden = false
        self.downImage.image = UIImage(named: "im_download_ing")
        let opts: UIView.AnimationOptions = [.autoreverse , .repeat]
        UIView.animate(withDuration: 0.5, delay: 0, options: opts, animations: {
            self.downImage.alpha = 0
        }, completion: { _ in
            self.downImage.alpha = 1
        })
        self.currenProgressView.progressLayer.strokeColor = YCColorStanBlue.cgColor
        let meaurNet = LYDownFileNetTools(block: {speed,progress in
            let kdSpeedStr = "\(QBTools.formatBandWidth(UInt64(speed))!)"
            let kbSpeedDate = "\(QBTools.formatKbFileSize(UInt64(speed))!)"
//            print("即使速度\(kdSpeedStr)")
            //返回的是个可选值，不一定有值，也可能是nill
            let double = Double(kdSpeedStr)
            //返回的double是个可选值，所以需要给个默认值或者用!强制解包
            let proData = CGFloat(double ?? 0)/100
            self.currenProgressView.progress = proData
            self.settingCountJumpText(kdSpeedStr: kdSpeedStr, kbSpeedStr: kbSpeedDate)
            if proData>=1{
                self.currenProgressView.progress = 1
            }
//            print("下载进度======\(kbSpeedStr)/S")
        }, finishMeasure: { speed in
            let kdSpeedStr = "\(QBTools.formatBandWidth(UInt64(speed))!)"
            let kbSpeedDate = "\(QBTools.formatKbFileSize(UInt64(speed))!)"

            self.downImage.isHidden = true
            self.downImage.image = UIImage(named: "im_download_wait")
            self.downLable.isHidden = false
            self.downDanwLable.isHidden = false
            if ISSELKBPS()=="no"{
                self.downLable.text = "\(kdSpeedStr)"
            }else{
                let speedStr:Array = kbSpeedDate.components(separatedBy:"/")
                self.downLable.text = "\(speedStr[0])"
                self.downDanwLable.text = "\(speedStr[1])/S"
            }
            //返回的是个可选值，不一定有值，也可能是nill
            let double = Double("\(kdSpeedStr)")
            //返回的double是个可选值，所以需要给个默认值或者用!强制解包
            let proData = CGFloat(double ?? 0)/100
            self.currenProgressView.progress = proData
            self.settingCountJumpText(kdSpeedStr: kdSpeedStr, kbSpeedStr: kbSpeedDate)

            if proData>=1{
                self.currenProgressView.progress = 1
            }
            self.speedModel.downSpeed = "\(kdSpeedStr)"
            self.speedModel.downOringSpeed = speed
            self.downImage.layer.removeAllAnimations()
            /** 测试上传 */
            self.testUpLoadSpeed()
        }, failedBlock: { error in
        })
//        let url = "http://down.sandai.net/thunder7/Thunder_dl_7.9.34.4908.exe"
//        meaurNet?.downLoadUrl = url
        meaurNet?.downLoadUrl = DownLoadUrl()
        meaurNet?.startMeasur()
        currenDownMeaurNet = meaurNet!
    }
    //MARK:=======测试上传宽带
    func testUpLoadSpeed(){
        /** 显示测试进度 */
        startButton.isHidden = true
        testSpeedView.isHidden = false
        testSpeedView.leftProgresView.image = UIImage(named: "leftUpProgress")
        testSpeedView.progressView.image = UIImage(named: "upLoadProgress")
        testSpeedView.titlelabel.text = "正在测试上传速度"
        scaleImageView.image = UIImage(named: "scaleUpImage")

        self.upLoadImage = self.headView.viewWithTag(102) as! UIImageView
        self.upLoadLable = self.headView.viewWithTag(1002) as! UILabel
        self.upLoadDanwLable = self.headView.viewWithTag(10002) as! UILabel
        self.upLoadImage.isHidden = false
        self.upLoadImage.image = UIImage(named: "im_upload_ing")
        self.currenProgressView.progressLayer.strokeColor = gof_ColorWithHex(0x8A2BE2).cgColor
        let opts: UIView.AnimationOptions = [.autoreverse , .repeat]
        UIView.animate(withDuration: 0.5, delay: 0, options: opts, animations: {
            self.upLoadImage.alpha = 0
        }, completion: { _ in
            self.upLoadImage.alpha = 1
        })
        let meaurNet = LYUpLoadFileNetTools(block: { speed,progress in
            let kdSpeedStr = "\(QBTools.formatBandWidth(UInt64(speed))!)"
            let kbSpeedDate = "\(QBTools.formatKbFileSize(UInt64(speed))!)"
            let double = Double(kdSpeedStr)
            let proData = CGFloat(double ?? 0)/100
            self.currenProgressView.progress = proData
            self.settingCountJumpText(kdSpeedStr: kdSpeedStr, kbSpeedStr: kbSpeedDate)

            if proData>=1{
                self.currenProgressView.progress = 1
            }
        }, finishMeasure: { speed in
            let kdSpeedStr = "\(QBTools.formatBandWidth(UInt64(speed))!)"
            let kbSpeedDate = "\(QBTools.formatKbFileSize(UInt64(speed))!)"
            self.upLoadImage.isHidden = true
            self.upLoadImage.image = UIImage(named: "im_upload_wait")
            self.upLoadLable.isHidden = false
            self.upLoadDanwLable.isHidden = false
            if ISSELKBPS()=="no"{
                self.upLoadLable.text = "\(kdSpeedStr)"
            }else{
                let speedStr:Array = kbSpeedDate.components(separatedBy:"/")
                self.upLoadLable.text = "\(speedStr[0])"
                self.upLoadDanwLable.text = "\(speedStr[1])/S"
            }
            //返回的是个可选值，不一定有值，也可能是nill
            let double = Double("\(kdSpeedStr)")
            //返回的double是个可选值，所以需要给个默认值或者用!强制解包
            let proData = CGFloat(double ?? 0)/100
            self.currenProgressView.progress = proData
            self.settingCountJumpText(kdSpeedStr: kdSpeedStr, kbSpeedStr: kbSpeedDate)
            if proData>=1{
                self.currenProgressView.progress = 1
            }
            self.speedModel.upSpeed = "\(kdSpeedStr)"
            self.speedModel.upOringSpeed = speed
            self.upLoadImage.layer.removeAllAnimations()
            self.startButton.isHidden = false
            self.testSpeedView.isHidden = true
            /** 保存测速数据 */
            self.saveSpeedInfoToLocal(model: self.speedModel)
            /** 测速完成跳转到详情页 */
            let detailVC = LYResultDetailController()
            detailVC.model = self.speedModel
            detailVC.isFromHome = true
            detailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailVC, animated: true)
        }, failedBlock: { error in
        })
        meaurNet.upLoadUrl = UpLoadUrl()
        meaurNet.startMeasur()
        currenUpMeaurNet = meaurNet
    }
    
    //MARK:=====设置测试速度
    func settingCountJumpText(kdSpeedStr:String,kbSpeedStr:String) {
        if ISSELKBPS() == "no"{
            self.currenProgressView.countJump.text = String(format: "%@\nMbps", kdSpeedStr)
        }else{
            let speedStr:Array = kbSpeedStr.components(separatedBy:"/")
            self.currenProgressView.countJump.text = String(format: "%@\n%@/S", speedStr[0],speedStr[1])
        }
    }
    
    //MARK:=====监听网络变化
    func currentNetReachability(view:LYCycleProgressView) {
        let manager = NetworkReachabilityManager()
        manager?.listener = { status in
            var statusStr: String?
            switch status {
            case .unknown:
                statusStr = "未识别的网络"
                view.wifiLable.text = "未识别"
                break
            case .notReachable:
                statusStr = "不可用的网络(未连接)"
                view.wifiLable.text = "无网络"
            case .reachable:
                if (manager?.isReachableOnWWAN)! {
                    statusStr = "2G,3G,4G...的网络"
                    self.speedModel.isWifi = "no"
                    view.wifiLable.text = "\(GetSystemInfoHelper.getPhoneNetName()!)"
                    self.speedModel.currenWifiName = view.wifiLable.text
                } else if (manager?.isReachableOnEthernetOrWiFi)! {
                    statusStr = "wifi的网络";
                    self.speedModel.isWifi = "yes"
                    view.wifiLable.text = "Wi-Fi:\n\(GetSystemInfoHelper.getWifiName()!)"
                    self.speedModel.currenWifiName = "Wi-Fi:\(GetSystemInfoHelper.getWifiName()!)"
                }
                print("===\(String(describing: statusStr))")
                break
            }
        }
        manager?.startListening()
    }
    //MARK:=====监听上传下载速度变化
    func listenNetworkSpeed() {
        BHBNetworkSpeed.share().startMonitoringNetworkSpeed()
        NotificationCenter.default.addObserver(self, selector: #selector(self.output), name: NSNotification.Name.networkReceivedSpeed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.output), name: NSNotification.Name.networkSendSpeed, object: nil)
    }
    @objc func output() {
        headView.upLable.text = BHBNetworkSpeed.share().sendNetworkSpeed
        headView.downLable.text = BHBNetworkSpeed.share().receivedNetworkSpeed
    }
    
    //MARK:=======保存测速数据到本地数据库
    func saveSpeedInfoToLocal(model:LYHomeModel){
        model.currenTime = LYTimeManager.shared.gaintCurrenTime()
        model.currenDate = LYTimeManager.shared.gaintCurrenDate()
        LYSpeedInfoManager.shared.addSpeedInfo(toLocalData: model)
    }
    lazy var updateView:LYUpgradeView = {
        let  updateView = LYUpgradeView(frame: CGRect(x: 0, y: Main_Screen_Height-40-kTabBarHeight-NaviBarHeight, width: Main_Screen_Width, height: 40))
        return updateView
    }()
}
