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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(bgImageView)
        self.view.addSubview(headView)
        headView.snp.makeConstraints { (make) in
            make.top.equalTo(StatusBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(kWidth(R: 180))
        }
        /** 创建进度条 */
        let progressView = LYCycleProgressView(frame: CGRect(x: 0, y: 0, width: Main_Screen_Width/3*2, height: Main_Screen_Width/3*2))
        progressView.center.x = self.view.center.x
        progressView.center.y = self.view.center.y+20
        progressView.progress = 0.0
        self.view.addSubview(progressView)
        currenProgressView = progressView

        /** 开始按钮 */
        let startButton = UIButton()
        self.view.addSubview(startButton)
        startButton.layer.borderWidth = 1
        startButton.layer.masksToBounds = true
        startButton.layer.borderColor = YCColorWhite.cgColor
        startButton.layer.cornerRadius = 25
        startButton.setTitle("开始", for: .normal)
        startButton.titleLabel?.font = YC_FONT_PFSC_Medium(18)
        startButton.setBackgroundImage(UIImage.init(named: "ic_glassButton"), for: .normal)
        startButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(-SafeBottomMargin-50)
            make.left.equalTo(100)
            make.right.equalTo(-100)
            make.height.equalTo(50)
        }
        startButton.addTarget(self, action: #selector(startButtonClick), for: .touchUpInside)
        /** 左箭头 */
        self.view.addSubview(leftArrow)
        leftArrow.image = UIImage(named: "leftArrow")
        leftArrow.frame = CGRect(x: 25, y: Main_Screen_Height-SafeBottomMargin-140, width: 40, height: 30)
        /** 右箭头 */
        self.view.addSubview(rightArrow)
        rightArrow.image = UIImage(named: "rightArrow")
        rightArrow.frame = CGRect(x: Main_Screen_Width-65, y: Main_Screen_Height-SafeBottomMargin-140, width: 40, height: 30)
        /** 监听网络变化 */
        currentNetReachability(view:progressView)
        /** 监听上传下载速度变化 */
        listenNetworkSpeed()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        super.viewWillAppear(animated)
        /** 动起来!!! */
        let opts: UIView.AnimationOptions = [.autoreverse , .repeat]
        UIView.animate(withDuration: 0.6, delay: 0, options: opts, animations: {
            self.leftArrow.frame.origin.x = 55
            self.rightArrow.frame.origin.x = Main_Screen_Width-95
        }, completion: { _ in
            self.leftArrow.frame.origin.x = 25
            self.rightArrow.frame.origin.x = Main_Screen_Width-65
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc private func startButtonClick()  {
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
    DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute:
    {
        self.pingServices = STDPingServices.startPingAddress(IPADRESS(), callbackHandler: {pingItem, pingItems in
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
            }
        })
    })
}
    //MARK:=======测试下载宽带
    func testDownloadSpeed(){
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
        self.currenProgressView.progressLayer.strokeColor = gof_ColorWithHex(0x00FF7F).cgColor
        let meaurNet = LYDownFileNetTools(block: {speed,progress in
            let kdSpeedStr = "\(QBTools.formatBandWidth(UInt64(speed))!)"
//            print("即使速度\(kdSpeedStr)")
            //返回的是个可选值，不一定有值，也可能是nill
            let double = Double(kdSpeedStr)
            //返回的double是个可选值，所以需要给个默认值或者用!强制解包
            let proData = CGFloat(double ?? 0)/100
            self.currenProgressView.progress = proData
            self.currenProgressView.countJump.text = String(format: "%@Mbps", kdSpeedStr)
            if proData>=1{
                self.currenProgressView.progress = 1
            }
            print("即使速度\(proData)")
        }, finishMeasure: { speed in
            let kdSpeedStr = "\(QBTools.formatBandWidth(UInt64(speed))!)"
            self.downImage.isHidden = true
            self.downImage.image = UIImage(named: "im_download_wait")
            self.downLable.isHidden = false
            self.downDanwLable.isHidden = false
            self.downLable.text = "\(kdSpeedStr)"
            //返回的是个可选值，不一定有值，也可能是nill
            let double = Double("\(kdSpeedStr)")
            //返回的double是个可选值，所以需要给个默认值或者用!强制解包
            let proData = CGFloat(double ?? 0)/100
            self.currenProgressView.progress = proData
            self.currenProgressView.countJump.text = String(format: "%@Mbps", kdSpeedStr)
            if proData>=1{
                self.currenProgressView.progress = 1
            }
            self.speedModel.downSpeed = self.downLable.text
            self.downImage.layer.removeAllAnimations()
            /** 测试上传 */
            self.testUpLoadSpeed()
        }, failedBlock: { error in
        })
//        let url = "http://down.sandai.net/thunder7/Thunder_dl_7.9.34.4908.exe"
//        meaurNet?.downLoadUrl = url
        meaurNet?.downLoadUrl = DownLoadUrl()
        meaurNet?.startMeasur()
    }
    //MARK:=======测试上传宽带
    func testUpLoadSpeed(){
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
            let double = Double(kdSpeedStr)
            let proData = CGFloat(double ?? 0)/100
            self.currenProgressView.progress = proData
            self.currenProgressView.countJump.text = String(format: "%@Mbps", kdSpeedStr)
            if proData>=1{
                self.currenProgressView.progress = 1
            }
        }, finishMeasure: { speed in
            let kdSpeedStr = "\(QBTools.formatBandWidth(UInt64(speed))!)"
            self.upLoadImage.isHidden = true
            self.upLoadImage.image = UIImage(named: "im_upload_wait")
            self.upLoadLable.isHidden = false
            self.upLoadDanwLable.isHidden = false
            self.upLoadLable.text = "\(kdSpeedStr)"
            //返回的是个可选值，不一定有值，也可能是nill
            let double = Double("\(kdSpeedStr)")
            //返回的double是个可选值，所以需要给个默认值或者用!强制解包
            let proData = CGFloat(double ?? 0)/100
            self.currenProgressView.progress = proData
            self.currenProgressView.countJump.text = String(format: "%@Mbps", kdSpeedStr)
            if proData>=1{
                self.currenProgressView.progress = 1
            }
            self.speedModel.upSpeed = self.upLoadLable.text
            self.upLoadImage.layer.removeAllAnimations()
            /** 保存测速数据 */
            self.saveSpeedInfoToLocal(model: self.speedModel)
            /** 测速完成跳转到详情页 */
            let detailVC = LYResultDetailController()
            detailVC.model = self.speedModel
            detailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailVC, animated: true)
        }, failedBlock: { error in
        })
        meaurNet.upLoadUrl = UpLoadUrl()
        meaurNet.startMeasur()
    }
    
    //MARK:=====添加背景图
    private lazy var bgImageView:UIImageView = {
        let  bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Main_Screen_Width, height: Main_Screen_Height))
        bgImageView.image = UIImage(named:"im_bg_home")
        return bgImageView
    }()
    
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
                    view.wifiLable.text = "\(GetSystemInfoHelper.getPhoneNetName()!)"
                } else if (manager?.isReachableOnEthernetOrWiFi)! {
                    statusStr = "wifi的网络";
                    view.wifiLable.text = "Wifi:\n\(GetSystemInfoHelper.getWifiName()!)"
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

}
