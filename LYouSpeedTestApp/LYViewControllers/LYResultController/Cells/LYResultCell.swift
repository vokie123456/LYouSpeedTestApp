//
//  LYResultCell.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/2.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

class LYResultCell: UITableViewCell {
    let timeLable = UILabel()
    let netImage = UIImageView()
    let yancContentLable = UILabel()
    let downContentLable = UILabel()
    let upContentLable = UILabel()
    let dwLable = UILabel()
    let upLable = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = YCColorGray
        creatUI()
    }
    
    func creatUI() {
        /** 背景框 */
        let bgView = UIView()
        bgView.backgroundColor = YCColorWhite
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = YCColorWhite.cgColor
        bgView.layer.cornerRadius = 5
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(80)
        }
        /** 时间 */
        bgView.addSubview(timeLable)
        timeLable.text = "12:16"
        timeLable.font = YC_FONT_PFSC_Medium(12)
        timeLable.textColor = YCColorBlack
        timeLable.alpha = 0.8
        timeLable.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.top.equalTo(12)
        }
        /** 网络 */
        bgView.addSubview(netImage)
        netImage.image = UIImage(named: "im_network_wifi")
        netImage.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(timeLable.snp.bottom).offset(13)
            make.width.equalTo(21)
            make.height.equalTo(15)
        }
        let line = UIView()
        bgView.addSubview(line)
        line.backgroundColor = YCColorWhite
        line.snp.makeConstraints { (make) in
            make.left.equalTo(timeLable.snp.right).offset(20)
            make.top.equalTo(12)
            make.width.equalTo(1)
            make.height.equalTo(55)
        }
        /** 延迟 */
        let yanchiLable = UILabel()
        bgView.addSubview(yanchiLable)
        yanchiLable.text = "延迟"
        yanchiLable.font = YC_FONT_PFSC_Medium(12)
        yanchiLable.textColor = YCColorBlack
        yanchiLable.alpha = 0.8
        yanchiLable.snp.makeConstraints { (make) in
            make.left.equalTo(line).offset(20)
            make.top.equalTo(12)
        }
        bgView.addSubview(yancContentLable)
        yancContentLable.text = "0.0"
        yancContentLable.font = YC_FONT_PFSC_Semibold(20)
        yancContentLable.textColor = YCColorStanBlue
        yancContentLable.snp.makeConstraints { (make) in
            make.left.equalTo(line).offset(20)
            make.top.equalTo(yanchiLable.snp.bottom).offset(0)
        }
        let ycLable = UILabel()
        bgView.addSubview(ycLable)
        ycLable.text = "ms"
        ycLable.font = YC_FONT_PFSC_Medium(12)
        ycLable.textColor = YCColorBlack
        ycLable.alpha = 0.8
        ycLable.snp.makeConstraints { (make) in
            make.left.equalTo(line).offset(20)
            make.top.equalTo(yancContentLable.snp.bottom).offset(0)
        }
        /** 下载 */
        let downLoadLable = UILabel()
        bgView.addSubview(downLoadLable)
        downLoadLable.text = "下载"
        downLoadLable.font = YC_FONT_PFSC_Medium(12)
        downLoadLable.textColor = YCColorBlack
        downLoadLable.alpha = 0.8
        downLoadLable.snp.makeConstraints { (make) in
            make.left.equalTo(Main_Screen_Width/2-40)
            make.top.equalTo(12)
        }
        bgView.addSubview(downContentLable)
        downContentLable.text = "0.0"
        downContentLable.font = YC_FONT_PFSC_Semibold(20)
        downContentLable.textColor = YCColorStanBlue
        downContentLable.snp.makeConstraints { (make) in
            make.left.equalTo(Main_Screen_Width/2-40)
            make.top.equalTo(downLoadLable.snp.bottom).offset(0)
        }
        bgView.addSubview(dwLable)
        dwLable.text = "Mbps"
        dwLable.font = YC_FONT_PFSC_Medium(12)
        dwLable.textColor = YCColorBlack
        dwLable.alpha = 0.8
        dwLable.snp.makeConstraints { (make) in
            make.left.equalTo(Main_Screen_Width/2-40)
            make.top.equalTo(downContentLable.snp.bottom).offset(0)
        }
        /** 上传 */
        let upLoadLable = UILabel()
        bgView.addSubview(upLoadLable)
        upLoadLable.text = "上传"
        upLoadLable.font = YC_FONT_PFSC_Medium(12)
        upLoadLable.textColor = YCColorBlack
        upLoadLable.alpha = 0.8
        upLoadLable.snp.makeConstraints { (make) in
            make.left.equalTo(Main_Screen_Width/2+40)
            make.top.equalTo(12)
        }
        bgView.addSubview(upContentLable)
        upContentLable.text = "0.0"
        upContentLable.font = YC_FONT_PFSC_Semibold(20)
        upContentLable.textColor = YCColorStanBlue
        upContentLable.snp.makeConstraints { (make) in
            make.left.equalTo(Main_Screen_Width/2+40)
            make.top.equalTo(upLoadLable.snp.bottom).offset(0)
        }
        bgView.addSubview(upLable)
        upLable.text = "Mbps"
        upLable.font = YC_FONT_PFSC_Medium(12)
        upLable.textColor = YCColorBlack
        upLable.alpha = 0.8
        upLable.snp.makeConstraints { (make) in
            make.left.equalTo(Main_Screen_Width/2+40)
            make.top.equalTo(upContentLable.snp.bottom).offset(0)
        }
        /** 箭头 */
        let arrowImage = UIImageView()
        bgView.addSubview(arrowImage)
        arrowImage.image = UIImage(named: "resultBackToRight")
        arrowImage.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.centerY.equalToSuperview()
            make.width.equalTo(8)
            make.height.equalTo(15)
        }
    }
    
    func gaintInfoModel(model:LYSpeedInfo) {
        timeLable.text = model.currenTime
        yancContentLable.text = model.delayeSpeed
        if model.isWifi=="no" {
            netImage.image = UIImage(named: "im_network_wifi")
        }else{
            netImage.image = UIImage(named: "im_network_wifi")
        }
        downContentLable.text = model.downSpeed
        upContentLable.text = model.upSpeed
        if ISSELKBPS()=="no" {
            downContentLable.text = model.downSpeed
            dwLable.text = "Mbps"
            upContentLable.text = model.upSpeed
            upLable.text = "Mbps"
        }else{
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
