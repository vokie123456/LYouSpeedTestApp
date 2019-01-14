//
//  LYDetailContentView.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/4.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

class LYDetailContentView: UIView {
    var speedButtonBlock:(()->Void)?
    let titleLable = UILabel()
    let rankingImage = UIImageView()
    var titleArray = ["全国","我","全省"]
    var dateArray = ["71.5Mbps","24.5Mbps","49.8Mbps"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = YCColorWhite
        creatUI()
    }
    func creatUI(){
        /** 标题 */
//        let titleLable = UILabel()
//        titleLable.text = "网速排名"
//        titleLable.textColor = YCColorBlack
//        titleLable.alpha = 0.8
//        titleLable.font = YC_FONT_PFSC_Medium(16)
//        self.addSubview(titleLable)
//        titleLable.snp.makeConstraints { (make) in
//            make.left.equalTo(20)
//            make.top.equalTo(15)
//        }
        /** 排名图片 */
        rankingImage.isUserInteractionEnabled = true
        rankingImage.layer.masksToBounds = true
        rankingImage.layer.cornerRadius = 5
        rankingImage.image = UIImage(named: "cn_rank0")
        self.addSubview(rankingImage)
        rankingImage.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(-0)
            make.height.equalTo(240)
        }
        titleLable.text = "我是网速季军"
        titleLable.textColor = YCColorWhite
        titleLable.textAlignment = NSTextAlignment.center
        titleLable.font = YC_FONT_PFSC_Medium(50/2)
        rankingImage.addSubview(titleLable)
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(10)
        }
        /** 晒网速 */
        let speedButton = UIButton()
        speedButton.layer.cornerRadius = 20
        speedButton.backgroundColor = YCColorStanBlue
        speedButton.setTitle("晒网速", for: .normal)
        speedButton.titleLabel?.font = YC_FONT_PFSC_Medium(15)
        speedButton.setTitleColor(YCColorWhite, for: .normal)
        self.addSubview(speedButton)
        speedButton.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(rankingImage.snp.bottom).offset(20)
            make.right.equalTo(-40)
            make.height.equalTo(40)
        }
        speedButton.addTarget(self, action: #selector(speedButton(_:)), for: .touchUpInside)
        /** 全国/全省/我 */
        let indexW = 50
        for i in 0..<titleArray.count {
            /** 标题 */
            let titleLable = UILabel()
            rankingImage.addSubview(titleLable)
            titleLable.text = titleArray[i]
            titleLable.font = YC_FONT_PFSC_Medium(15)
            titleLable.textAlignment = NSTextAlignment.center
            titleLable.textColor = YCColorWhite
            titleLable.tag = i+10
            titleLable.snp.makeConstraints { (make) in
                make.bottom.equalTo(rankingImage).offset(-22)
                make.centerX.equalTo(rankingImage).offset(-100)
                make.width.equalTo(indexW)
            }
            if(titleLable.tag==11){
                titleLable.snp.updateConstraints { (make) in
                    make.centerX.equalTo(rankingImage)
                }
            }else if(titleLable.tag==12){
                titleLable.snp.updateConstraints { (make) in
                    make.centerX.equalTo(rankingImage).offset(100)
                }
            }
            
            /** 测试数据 */
            let dateLable = UILabel()
            rankingImage.addSubview(dateLable)
            dateLable.text = dateArray[i]
            dateLable.font = YC_FONT_PFSC_Medium(8)
            dateLable.tag = i+100
            dateLable.textAlignment = NSTextAlignment.center
            dateLable.textColor = YCColorWhite
            dateLable.snp.makeConstraints { (make) in
                make.bottom.equalTo(rankingImage).offset(-8)
                make.centerX.equalTo(rankingImage).offset(-100)
                make.width.equalTo(indexW+50)
            }
            if(dateLable.tag==101){
                dateLable.snp.updateConstraints { (make) in
                    make.centerX.equalTo(rankingImage)
                }
            }else if(dateLable.tag==102){
                dateLable.snp.updateConstraints { (make) in
                    make.centerX.equalTo(rankingImage).offset(100)
                }
            }
        }
    }
    
    @objc func speedButton(_ button:UIButton) {
        speedButtonBlock!()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func gaintInfoModel(infoModel:LYHomeModel) {
        //返回的是个可选值，不一定有值，也可能是nill
        let double = Double("\(infoModel.downSpeed!)")
        //返回的double是个可选值，所以需要给个默认值或者用!强制解包
        let downFloat = CGFloat(double ?? 0)
        if downFloat>=71.5{
            /** 第一名 */
//            rankingImage.image = UIImage(named: "cn_rank0")
            titleArray = ["全国","我","全省"]
            dateArray = ["71.5Mbps","\(downFloat)Mbps","49.8Mbps"]
        }else if downFloat<71.5 && downFloat>=49.8{
            /** 第二名 */
//            rankingImage.image = UIImage(named: "cn_rank1")
            titleArray = ["我","全国","全省"]
            dateArray = ["\(downFloat)Mbps","71.5Mbps","49.8Mbps"]
        }else if downFloat<49.8{
            /** 第三名 */
//            rankingImage.image = UIImage(named: "cn_rank2")
            titleArray = ["全省","全国","我"]
            dateArray = ["49.8Mbps","71.5Mbps","\(downFloat)Mbps"]
        }
        for i in 0..<dateArray.count {
            let titleLable:UILabel = self.viewWithTag(i+10) as! UILabel
            titleLable.text = titleArray[i]
            let dataLable:UILabel = self.viewWithTag(i+100) as! UILabel
            dataLable.text = dateArray[i]
//            if(titleLable.text=="我"){
//                titleLable.textColor = gof_ColorWithHex(0x1BB955)
//                dataLable.textColor = gof_ColorWithHex(0x1BB955)
//            }
        }
    }
}
