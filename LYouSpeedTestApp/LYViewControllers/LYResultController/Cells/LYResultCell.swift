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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = YCColorMain
        creatUI()
    }
    
    func creatUI() {
        /** 背景框 */
        let bgView = UIView()
        bgView.backgroundColor = gof_ColorWithHex(0x212732)
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = YCColorWhite.cgColor
        bgView.layer.cornerRadius = 5
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(0)
            make.height.equalTo(100)
        }
        /** 时间 */
        bgView.addSubview(timeLable)
        timeLable.text = "12:16"
        timeLable.font = YC_FONT_PFSC_Medium(14)
        timeLable.textColor = YCColorWhite
        timeLable.alpha = 0.6
        timeLable.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(15)
        }
        /** 网络 */
        bgView.addSubview(netImage)
        netImage.image = UIImage(named: "im_network_wifi")
        netImage.alpha = 0.8
        netImage.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(timeLable.snp.bottom).offset(15)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        let line = UIView()
        bgView.addSubview(line)
        line.backgroundColor = YCColorWhite
        line.alpha = 0.6
        line.snp.makeConstraints { (make) in
            make.left.equalTo(timeLable.snp.right).offset(20)
            make.top.equalTo(20)
            make.width.equalTo(1)
            make.height.equalTo(60)
        }
        /** 延迟 */
        let yanchiLable = UILabel()
        bgView.addSubview(yanchiLable)
        yanchiLable.text = "延迟"
        yanchiLable.font = YC_FONT_PFSC_Medium(14)
        yanchiLable.textColor = YCColorWhite
        yanchiLable.alpha = 0.6
        yanchiLable.snp.makeConstraints { (make) in
            make.left.equalTo(line).offset(20)
            make.top.equalTo(15)
        }
        bgView.addSubview(yancContentLable)
        yancContentLable.text = "49"
        yancContentLable.font = YC_FONT_PFSC_Semibold(20)
        yancContentLable.textColor = YCColorWhite
        yancContentLable.snp.makeConstraints { (make) in
            make.left.equalTo(line).offset(20)
            make.top.equalTo(yanchiLable.snp.bottom).offset(5)
        }
        let ycLable = UILabel()
        bgView.addSubview(ycLable)
        ycLable.text = "ms"
        ycLable.font = YC_FONT_PFSC_Medium(14)
        ycLable.textColor = YCColorWhite
        ycLable.snp.makeConstraints { (make) in
            make.left.equalTo(line).offset(20)
            make.top.equalTo(yancContentLable.snp.bottom).offset(0)
        }
        /** 下载 */
        let downLoadLable = UILabel()
        bgView.addSubview(downLoadLable)
        downLoadLable.text = "下载"
        downLoadLable.font = YC_FONT_PFSC_Medium(14)
        downLoadLable.textColor = YCColorWhite
        downLoadLable.alpha = 0.6
        downLoadLable.snp.makeConstraints { (make) in
            make.left.equalTo(Main_Screen_Width/2-40)
            make.top.equalTo(15)
        }
        bgView.addSubview(downContentLable)
        downContentLable.text = "149.8"
        downContentLable.font = YC_FONT_PFSC_Semibold(20)
        downContentLable.textColor = YCColorWhite
        downContentLable.snp.makeConstraints { (make) in
            make.left.equalTo(Main_Screen_Width/2-40)
            make.top.equalTo(downLoadLable.snp.bottom).offset(5)
        }
        let dwLable = UILabel()
        bgView.addSubview(dwLable)
        dwLable.text = "Mbps"
        dwLable.font = YC_FONT_PFSC_Medium(14)
        dwLable.textColor = YCColorWhite
        dwLable.snp.makeConstraints { (make) in
            make.left.equalTo(Main_Screen_Width/2-40)
            make.top.equalTo(downContentLable.snp.bottom).offset(0)
        }
        /** 上传 */
        let upLoadLable = UILabel()
        bgView.addSubview(upLoadLable)
        upLoadLable.text = "上传"
        upLoadLable.font = YC_FONT_PFSC_Medium(14)
        upLoadLable.textColor = YCColorWhite
        upLoadLable.alpha = 0.6
        upLoadLable.snp.makeConstraints { (make) in
            make.left.equalTo(Main_Screen_Width/2+40)
            make.top.equalTo(15)
        }
        bgView.addSubview(upContentLable)
        upContentLable.text = "49.8"
        upContentLable.font = YC_FONT_PFSC_Semibold(20)
        upContentLable.textColor = YCColorWhite
        upContentLable.snp.makeConstraints { (make) in
            make.left.equalTo(Main_Screen_Width/2+40)
            make.top.equalTo(upLoadLable.snp.bottom).offset(5)
        }
        let upLable = UILabel()
        bgView.addSubview(upLable)
        upLable.text = "Mbps"
        upLable.font = YC_FONT_PFSC_Medium(14)
        upLable.textColor = YCColorWhite
        upLable.snp.makeConstraints { (make) in
            make.left.equalTo(Main_Screen_Width/2+40)
            make.top.equalTo(upContentLable.snp.bottom).offset(0)
        }
        /** 箭头 */
        let arrowImage = UIImageView()
        bgView.addSubview(arrowImage)
        arrowImage.image = UIImage(named: "backToRight")
        arrowImage.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.centerY.equalToSuperview()
            make.width.equalTo(15)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
