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
            make.width.equalTo(kWidth(R: 80))
            make.height.equalTo(kWidth(R: 80))
        }
        /** 版本号 */
        self.view.addSubview(versionLable)
        versionLable.textColor = YCColorWhite
        versionLable.textAlignment = NSTextAlignment.right
        versionLable.font = YC_FONT_PFSC_Medium(16)
        versionLable.text = "1.0.0"
        versionLable.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(iconImageView.snp.bottom).offset(42)
            make.width.equalTo(100)
        }
        
        
        let titleArr = ["当前版本","隐私协议","服务条款"]
        for i in 0..<3 {
            let titlelable = UILabel()
            self.view.addSubview(titlelable)
            titlelable.text = titleArr[i]
            titlelable.font = YC_FONT_PFSC_Medium(16)
            titlelable.textColor = YCColorWhite
            titlelable.snp.makeConstraints { (make) in
                make.left.equalTo(20)
                make.top.equalTo(iconImageView.snp.bottom).offset(42+i*55)
                make.width.equalTo(100)
            }
            let line = UIView()
            line.backgroundColor = YCColorWhite
            line.alpha = 0.1
            self.view.addSubview(line)
            line.snp.makeConstraints { (make) in
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.top.equalTo(titlelable.snp.bottom).offset(15)
                make.height.equalTo(1)
            }
            let arrow = UIImageView()
            arrow.image = UIImage(named:"backToRight")
            self.view.addSubview(arrow)
            arrow.alpha = 0.8
            arrow.snp.makeConstraints { (make) in
                make.right.equalTo(-20)
                make.top.equalTo(iconImageView.snp.bottom).offset(48+i*55)
                make.width.equalTo(10)
                make.height.equalTo(14)
            }
            if i==0{
                arrow.isHidden = true
            }
            let selButton = UIButton()
            selButton.tag = i+10
            self.view.addSubview(selButton)
            selButton.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.top.equalTo(iconImageView.snp.bottom).offset(30+i*55)
                make.height.equalTo(50)
            }
           selButton.addTarget(self, action: #selector(selButtonClick(_:)), for:.touchUpInside)
        }
    }
    @objc func selButtonClick(_ button:UIButton){
        
    }
}
