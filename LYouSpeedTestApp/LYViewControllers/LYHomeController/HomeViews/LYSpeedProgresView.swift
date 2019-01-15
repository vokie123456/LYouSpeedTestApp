//
//  LYSpeedProgresView.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/15.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

class LYSpeedProgresView: UIView {
    let titlelabel = UILabel()
    let progressView = UIImageView()
    let leftProgresView = UIImageView()
    let rightProgresView = UIImageView()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.0) // 设置半透明颜色
        creatUI()
    }
    
    func creatUI(){
        titlelabel.text = "正在测试下载速度"
        titlelabel.font = YC_FONT_PFSC_Medium(9)
        titlelabel.textColor = YCColorTitleLight
        titlelabel.textAlignment = NSTextAlignment.center
        self.addSubview(titlelabel)
        titlelabel.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(5)
        }
//        progressView.progressTintColor = YCColorStanBlue
//        progressView.trackTintColor = YCColorGray
//        progressView.progress = 1
//        progressView.layer.cornerRadius = 2
        progressView.image = UIImage(named: "downLoadProgress")
        self.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titlelabel.snp.bottom).offset(5)
            make.width.equalTo(150)
            make.height.equalTo(3)
        }
        /** 左Icon */
        leftProgresView.image = UIImage(named: "leftDownProgress")
        self.addSubview(leftProgresView)
        leftProgresView.snp.makeConstraints { (make) in
            make.left.equalTo(progressView.snp.left).offset(-35)
            make.top.equalTo(15)
            make.width.equalTo(17)
            make.height.equalTo(17)
        }
        /** 右Icon */
        rightProgresView.image = UIImage(named: "rightProgress")
        self.addSubview(rightProgresView)
        rightProgresView.snp.makeConstraints { (make) in
            make.left.equalTo(progressView.snp.right).offset(25)
            make.top.equalTo(15)
            make.width.equalTo(12)
            make.height.equalTo(17)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
