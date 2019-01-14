//
//  LYAboutUsController.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/28.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit

class LYAboutUsController: LYBaseController {
    let versionLable = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "关于"
        /** Icon图标 */
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named:"shareImage")
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 15
        self.view.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(NaviBarHeight-20)
            make.width.equalTo(kWidth(R: 60))
            make.height.equalTo(kWidth(R: 60))
        }
        
        
        
        let titleArr = ["当前版本","隐私协议","服务条款"]
        for i in 0..<3 {
            let bgView = UIView()
            bgView.backgroundColor = YCColorWhite
            self.view.addSubview(bgView)
            bgView.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.top.equalTo(iconImageView.snp.bottom).offset(40+i*50)
                make.height.equalTo(50)
            }
            
            let titlelable = UILabel()
            bgView.addSubview(titlelable)
            titlelable.text = titleArr[i]
            titlelable.font = YC_FONT_PFSC_Medium(13)
            titlelable.textColor = YCColorBlack
            titlelable.alpha = 0.8
            titlelable.snp.makeConstraints { (make) in
                make.left.equalTo(20)
                make.top.equalTo(15)
                make.width.equalTo(100)
            }
            let line = UIView()
            line.backgroundColor = YCColorGray
            bgView.addSubview(line)
            line.snp.makeConstraints { (make) in
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.top.equalTo(titlelable.snp.bottom).offset(15)
                make.height.equalTo(1)
            }
            let arrow = UIImageView()
            arrow.image = UIImage(named:"backToRight")
            bgView.addSubview(arrow)
            arrow.snp.makeConstraints { (make) in
                make.right.equalTo(-20)
                make.top.equalTo(15)
                make.width.equalTo(10)
                make.height.equalTo(15)
            }
            if i==0{
                arrow.isHidden = true
            }
            let selButton = UIButton()
            selButton.tag = i+10
            bgView.addSubview(selButton)
            selButton.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.top.equalTo(0)
                make.height.equalTo(50)
            }
           selButton.addTarget(self, action: #selector(selButtonClick(_:)), for:.touchUpInside)
        }
        /** 版本号 */
        self.view.addSubview(versionLable)
        versionLable.textColor = YCColorMainGray
        versionLable.textAlignment = NSTextAlignment.right
        versionLable.font = YC_FONT_PFSC_Medium(13)
        let infoDictionary = Bundle.main.infoDictionary
        let app_Version = infoDictionary!["CFBundleShortVersionString"] as? String
        versionLable.text = app_Version
        versionLable.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(iconImageView.snp.bottom).offset(54)
            make.width.equalTo(100)
        }
    }
    
    @objc func selButtonClick(_ button:UIButton){
        if button.tag==11 {
            /** 隐私协议 */
            let serverVC = LYServerWebController()
            serverVC.titleStr = "1"
            self.navigationController?.pushViewController(serverVC, animated: true)
        }else if button.tag==12{
            /** 服务条款 */
            let serverVC = LYServerWebController()
            serverVC.titleStr = "2"
            self.navigationController?.pushViewController(serverVC, animated: true)
        }
    }
}
