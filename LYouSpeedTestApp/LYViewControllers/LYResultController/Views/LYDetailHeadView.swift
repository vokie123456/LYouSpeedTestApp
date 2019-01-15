//
//  LYDetailHeadView.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/3.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

class LYDetailHeadView: UIView {
    var restartButtonBlock:(()->Void)?
    let discritlable = UILabel()
    let restartButton = UIButton()

    let speedLable = UILabel()
    let showKdImage = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
    }
    func creatUI(){
        let bgImage = UIImageView()
        bgImage.isUserInteractionEnabled = true
        bgImage.backgroundColor = YCColorWhite
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
            make.centerX.equalTo(bgImage).offset(-15)
            make.top.equalTo(16)
            make.width.equalTo(14)
            make.height.equalTo(14)
        }
        let kdLable = UILabel()
        kdLable.text = "带宽"
        kdLable.textColor = YCColorTitleLight
        kdLable.font = YC_FONT_PFSC_Medium(13)
        bgImage.addSubview(kdLable)
        kdLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgImage).offset(10)
            make.top.equalTo(15)
        }
        /** 进度条 */
        showKdImage.image = UIImage(named: "icon_bandwidthBack_1")
        bgImage.addSubview(showKdImage)
        showKdImage.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(kdLable.snp.bottom).offset(5)
            make.width.equalTo(35)
            make.height.equalTo(32)
        }
        speedLable.text = "0.00M"
        speedLable.textColor = YCColorWhite
        if let font = UIFont(name: "Helvetica-Bold", size: 9) {
            speedLable.font = font
        }
        showKdImage.addSubview(speedLable)
        speedLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(showKdImage)
            make.centerY.equalTo(showKdImage).offset(-3)
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
        slowLable.font = YC_FONT_PFSC_Medium(13)
        slowLable.textColor = YCColorDarkRed
        bgImage.addSubview(slowLable)
        slowLable.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(progresImage.snp.bottom).offset(5)
        }
        /** 飞快 */
        let quikLable = UILabel()
        quikLable.text = "飞快"
        quikLable.font = YC_FONT_PFSC_Medium(13)
        quikLable.textColor = YCColorLightBlue
        bgImage.addSubview(quikLable)
        quikLable.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(progresImage.snp.bottom).offset(5)
        }
        /** 北京平均带宽 */
        let bjKdLable = UILabel()
        bjKdLable.text = "北京平均带宽:71.5M"
        bjKdLable.font = YC_FONT_PFSC_Medium(11)
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
            /** 标题 */
            let titleLable = UILabel()
            self.addSubview(titleLable)
            titleLable.text = titleArray[i]
            titleLable.font = YC_FONT_PFSC_Medium(11)
            titleLable.textAlignment = NSTextAlignment.center
            titleLable.textColor = YCColorTitleLight
            titleLable.alpha = 0.5
            titleLable.snp.makeConstraints { (make) in
                make.top.equalTo(bjKdLable).offset(50)
                make.left.equalTo(i*indexW)
                make.width.equalTo(indexW)
            }
            /** 测试数据 */
            let dateLable = UILabel()
            self.addSubview(dateLable)
            dateLable.text = dateArray[i]
            dateLable.tag = i+10
            dateLable.font = YC_FONT_PFSC_Medium(12)
            dateLable.textAlignment = NSTextAlignment.center
            dateLable.textColor = YCColorStanBlue
            dateLable.snp.makeConstraints { (make) in
                make.top.equalTo(bjKdLable).offset(80)
                make.left.equalTo(i*indexW)
                make.width.equalTo(indexW)
            }
        }
        discritlable.text = "比平均网速低哦，再测一次试试吧~"
        discritlable.textColor = YCColorTitleLight
        discritlable.textAlignment = NSTextAlignment.center
        discritlable.font = YC_FONT_PFSC_Medium(8)
        self.addSubview(discritlable)
        discritlable.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(bjKdLable.snp.bottom).offset(100)
        }
        /** 重新测试 */
        restartButton.layer.cornerRadius = 20
        restartButton.backgroundColor = YCColorStanBlue
        restartButton.setTitle("开始", for: .normal)
        restartButton.titleLabel?.font = YC_FONT_PFSC_Medium(15)
        restartButton.setTitleColor(YCColorWhite, for: .normal)
        self.addSubview(restartButton)
        restartButton.snp.makeConstraints { (make) in
            make.left.equalTo(80)
            make.top.equalTo(discritlable.snp.bottom).offset(20)
            make.right.equalTo(-80)
            make.height.equalTo(40)
        }
        restartButton.addTarget(self, action: #selector(restartButton(_:)), for: .touchUpInside)
    }
    
    func gaintInfoModel(infoModel:LYHomeModel) {
        speedLable.text = "\(infoModel.downSpeed!)M"
        let dateArray = ["\(infoModel.delay!) ms","\(infoModel.downSpeed!) Mbps","\(infoModel.upSpeed!) Mbps"]
        for i in 0..<dateArray.count {
            let dateLable:UILabel = self.viewWithTag(i+10) as! UILabel
            dateLable.text = dateArray[i]
        }
        showKdImage.image = UIImage(named: "icon_bandwidthBack_1")

        //返回的是个可选值，不一定有值，也可能是nill
        let double = Double("\(infoModel.downSpeed!)")
        //返回的double是个可选值，所以需要给个默认值或者用!强制解包
        let downFloat = CGFloat(double ?? 0)
//        if downFloat<=18 {
//            showKdImage.image = UIImage(named: "icon_bandwidthBack_1")
//        }else if downFloat>18 && downFloat<=55{
//            showKdImage.image = UIImage(named: "icon_bandwidthBack_2")
//        }else if downFloat>55 && downFloat<=90{
//            showKdImage.image = UIImage(named: "icon_bandwidthBack_3")
//        }else if downFloat>90{
//            showKdImage.image = UIImage(named: "icon_bandwidthBack_4")
//        }
        var progress = downFloat/100
        if downFloat>90 {
            progress = 90/100
        }
        if downFloat==0.0{
            progress = 5/100
        }
        showKdImage.snp.updateConstraints { (make) in
            make.left.equalTo((Main_Screen_Width-40)*progress)
        }
    }
    
    @objc func restartButton(_ button:UIButton) {
        restartButtonBlock!()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}






