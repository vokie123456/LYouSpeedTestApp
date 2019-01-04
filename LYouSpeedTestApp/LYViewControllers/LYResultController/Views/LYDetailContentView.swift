//
//  LYDetailContentView.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/4.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

class LYDetailContentView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = YCColorWhite
        creatUI()
    }
    func creatUI(){
        /** 标题 */
        let titleLable = UILabel()
        titleLable.text = "网速排名"
        titleLable.textColor = YCColorBlack
        titleLable.alpha = 0.8
        titleLable.font = YC_FONT_PFSC_Medium(16)
        self.addSubview(titleLable)
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(15)
        }
        /** 排名图片 */
        let rankingImage = UIImageView()
        rankingImage.isUserInteractionEnabled = true
        rankingImage.layer.masksToBounds = true
        rankingImage.layer.cornerRadius = 5
        rankingImage.image = UIImage(named: "cn_rank0")
        self.addSubview(rankingImage)
        rankingImage.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(titleLable.snp.bottom).offset(15)
            make.right.equalTo(-20)
            make.height.equalTo(320)
        }
        /** 晒网速 */
        let speedButton = UIButton()
        speedButton.layer.cornerRadius = 25
        speedButton.backgroundColor = gof_ColorWithHex(0x1BB955)
        speedButton.setTitle("晒网速", for: .normal)
        speedButton.titleLabel?.font = YC_FONT_PFSC_Medium(17)
        speedButton.setTitleColor(YCColorWhite, for: .normal)
        self.addSubview(speedButton)
        speedButton.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(rankingImage.snp.bottom).offset(15)
            make.right.equalTo(-40)
            make.height.equalTo(50)
        }
        /** 全国/全省/我 */
        let titleArray = ["全国","我","全省"]
        let dateArray = ["49.8Mbps","24.5Mbps","71.5Mbps"]
        let indexW = 50
        for i in 0..<titleArray.count {
            /** 标题 */
            let titleLable = UILabel()
            rankingImage.addSubview(titleLable)
            titleLable.text = titleArray[i]
            titleLable.font = YC_FONT_PFSC_Medium(14)
            titleLable.textAlignment = NSTextAlignment.center
            titleLable.textColor = YCColorBlack
            titleLable.tag = i+10
            titleLable.alpha = 0.6
            titleLable.snp.makeConstraints { (make) in
                make.bottom.equalTo(rankingImage).offset(-30)
                make.centerX.equalTo(rankingImage).offset(-60)
                make.width.equalTo(indexW)
            }
            if(titleLable.tag==11){
                titleLable.snp.updateConstraints { (make) in
                    make.centerX.equalTo(rankingImage)
                }
            }else if(titleLable.tag==12){
                titleLable.snp.updateConstraints { (make) in
                    make.centerX.equalTo(rankingImage).offset(60)
                }
            }
            if(titleLable.text=="我"){
                titleLable.textColor = gof_ColorWithHex(0x1BB955)
            }
            /** 测试数据 */
            let dateLable = UILabel()
            rankingImage.addSubview(dateLable)
            dateLable.text = dateArray[i]
            dateLable.font = YC_FONT_PFSC_Medium(10)
            dateLable.tag = i+100
            dateLable.textAlignment = NSTextAlignment.center
            dateLable.textColor = YCColorBlack
            dateLable.alpha = 0.6
            dateLable.snp.makeConstraints { (make) in
                make.bottom.equalTo(rankingImage).offset(-8)
                make.centerX.equalTo(rankingImage).offset(-60)
                make.width.equalTo(indexW+50)
            }
            if(dateLable.tag==101){
                dateLable.snp.updateConstraints { (make) in
                    make.centerX.equalTo(rankingImage)
                }
            }else if(dateLable.tag==102){
                dateLable.snp.updateConstraints { (make) in
                    make.centerX.equalTo(rankingImage).offset(60)
                }
            }
            if(titleLable.text=="我"){
                dateLable.textColor = gof_ColorWithHex(0x1BB955)
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
