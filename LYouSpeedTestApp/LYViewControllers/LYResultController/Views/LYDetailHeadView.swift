//
//  LYDetailHeadView.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/3.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

class LYDetailHeadView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
    }
    func creatUI(){
        let bgImage = UIImageView()
        bgImage.isUserInteractionEnabled = true
        bgImage.image = UIImage(named: "")
        self.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self)
            make.height.equalTo(self)
        }
        /** 宽带 */
        let kdImage = UIImageView()
        kdImage.isUserInteractionEnabled = true
        kdImage.image = UIImage(named: "icon_earth_white")
        bgImage.addSubview(kdImage)
        kdImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgImage).offset(-20)
            make.top.equalTo(9)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        let kdLable = UILabel()
        kdLable.text = "带宽"
        kdLable.textColor = YCColorWhite
        kdLable.font = YC_FONT_PFSC_Medium(16)
        bgImage.addSubview(kdLable)
        kdLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgImage).offset(10)
            make.top.equalTo(8)
        }
        /** 进度条 */
        let showKdImage = UIImageView()
        showKdImage.image = UIImage(named: "icon_bandwidthBack_1")
        bgImage.addSubview(showKdImage)
        showKdImage.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(kdLable.snp.bottom).offset(5)
            make.width.equalTo(70)
            make.height.equalTo(47)
        }
        let speedLable = UILabel()
        speedLable.text = "2.00M"
        speedLable.textColor = YCColorBlack
        if let font = UIFont(name: "Helvetica-Bold", size: 15) {
            speedLable.font = font
        }
        showKdImage.addSubview(speedLable)
        speedLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(showKdImage)
            make.centerY.equalTo(showKdImage).offset(-5)
        }
        let progresImage = UIImageView()
        progresImage.image = UIImage(named: "image_speedLine")
        bgImage.addSubview(progresImage)
        progresImage.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(showKdImage.snp.bottom).offset(0)
            make.height.equalTo(10)
        }
        /** 缓慢 */
        let slowLable = UILabel()
        slowLable.text = "缓慢"
        slowLable.font = YC_FONT_PFSC_Medium(15)
        slowLable.textColor = YCColorDarkRed
        bgImage.addSubview(slowLable)
        slowLable.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(progresImage.snp.bottom).offset(5)
        }
        /** 飞快 */
        let quikLable = UILabel()
        quikLable.text = "飞快"
        quikLable.font = YC_FONT_PFSC_Medium(15)
        quikLable.textColor = YCColorGreen
        bgImage.addSubview(quikLable)
        quikLable.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(progresImage.snp.bottom).offset(5)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}






