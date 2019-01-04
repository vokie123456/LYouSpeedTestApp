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
    let headView = LYHomeHeadView()
    var currenProgressView = LYCycleProgressView()
    let leftArrow = UIImageView()
    let rightArrow = UIImageView()
    
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
        progressView.progress = 0.3
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
    
    @objc private func startButtonClick()  {
        currenProgressView.progress = 0.6
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
    


}
