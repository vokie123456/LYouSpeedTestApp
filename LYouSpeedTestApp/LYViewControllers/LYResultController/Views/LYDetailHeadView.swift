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
        bgImage.backgroundColor = YCColorMain
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
        let pointLine = UIImageView()
        pointLine.image = UIImage(named: "icon_pointLine_green")
        bgImage.addSubview(pointLine)
        pointLine.snp.makeConstraints { (make) in
            make.right.equalTo(-43)
            make.top.equalTo(showKdImage.snp.bottom).offset(2)
            make.width.equalTo(7)
            make.height.equalTo(23)
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
        /** 北京平均带宽 */
        let bjKdLable = UILabel()
        bjKdLable.text = "北京平均带宽:71.5M"
        bjKdLable.font = YC_FONT_PFSC_Medium(15)
        bjKdLable.textAlignment = NSTextAlignment.right
        bjKdLable.textColor = YCColorGreen
        bgImage.addSubview(bjKdLable)
        bjKdLable.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(quikLable.snp.bottom).offset(3)
        }
        let dateArray = ["61 ms","24.5Mbps","20Mbps"]
        let titleArray = ["网络延迟","下载速度","上传速度"]
        let indexW = (Int)(Main_Screen_Width)/3
        for i in 0..<titleArray.count {
            /** 测试数据 */
            let dateLable = UILabel()
            self.addSubview(dateLable)
            dateLable.text = dateArray[i]
            dateLable.font = YC_FONT_PFSC_Medium(16)
            dateLable.textAlignment = NSTextAlignment.center
            dateLable.textColor = YCColorWhite
            dateLable.snp.makeConstraints { (make) in
                make.top.equalTo(bjKdLable).offset(50)
                make.left.equalTo(i*indexW)
                make.width.equalTo(indexW)
            }
            /** 标题 */
            let titleLable = UILabel()
            self.addSubview(titleLable)
            titleLable.text = titleArray[i]
            titleLable.font = YC_FONT_PFSC_Medium(14)
            titleLable.textAlignment = NSTextAlignment.center
            titleLable.textColor = YCColorWhite
            titleLable.alpha = 0.5
            titleLable.snp.makeConstraints { (make) in
                make.top.equalTo(bjKdLable).offset(80)
                make.left.equalTo(i*indexW)
                make.width.equalTo(indexW)
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}






