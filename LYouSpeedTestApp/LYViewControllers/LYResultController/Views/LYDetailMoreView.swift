//
//  LYDetailMoreView.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/4.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

class LYDetailMoreView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = YCColorWhite
        creatUI()
    }
    func creatUI(){
        /** 标题 */
        let titleLable = UILabel()
        titleLable.text = "更多详情"
        titleLable.textColor = YCColorTitleLight
        titleLable.alpha = 0.8
        titleLable.font = YC_FONT_PFSC_Medium(15)
        self.addSubview(titleLable)
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(10)
        }
        let imageArray = ["im_video","im_game","im_image"]
        let titleArray = ["看视频","玩游戏","传图片"]
        for i in 0..<titleArray.count {
            /** 图标 */
            let iconImage = UIImageView()
            self.addSubview(iconImage)
            iconImage.tag = i+10000
            iconImage.image = UIImage(named: imageArray[i])
            iconImage.snp.makeConstraints { (make) in
                make.top.equalTo(titleLable.snp.bottom).offset(15+i*40)
                make.left.equalTo(22)
                make.width.equalTo(18)
                make.height.equalTo(18)
            }
            if iconImage.tag==10000{
                iconImage.snp.updateConstraints { (make) in
                    make.height.equalTo(16)
                }
            }
            if iconImage.tag==10001{
                iconImage.snp.updateConstraints { (make) in
                    make.top.equalTo(titleLable.snp.bottom).offset(15+i*38)
                }
            }
            if iconImage.tag==10002{
                iconImage.snp.updateConstraints { (make) in
                    make.top.equalTo(titleLable.snp.bottom).offset(15+i*41)
                    make.height.equalTo(15)
                }
            }
            
            /** 标题 */
            let titLable = UILabel()
            self.addSubview(titLable)
            titLable.text = titleArray[i]
            titLable.tag = i+10
            titLable.font = YC_FONT_PFSC_Medium(13)
            titLable.textColor = YCColorStanBlue
            titLable.snp.makeConstraints { (make) in
                make.top.equalTo(titleLable.snp.bottom).offset(15+i*40)
                make.left.equalTo(iconImage.snp.right).offset(20)
            }
            /** 进度条 */
            let progressLable = UILabel()
            self.addSubview(progressLable)
            progressLable.text = "1/5"
            progressLable.tag = i+100
            progressLable.font = YC_FONT_PFSC_Medium(12)
            progressLable.textColor = YCColorTitleLight
            progressLable.snp.makeConstraints { (make) in
                make.top.equalTo(titleLable.snp.bottom).offset(16+i*40)
                make.right.equalTo(-20)
            }
            let progressImage = UIImageView()
            self.addSubview(progressImage)
            progressImage.tag = i+1000
            progressImage.image = UIImage(named: "stupid_level3")
            progressImage.snp.makeConstraints { (make) in
                make.top.equalTo(titleLable.snp.bottom).offset(20+i*40)
                make.right.equalTo(progressLable.snp.left).offset(-10)
                make.width.equalTo(90)
                make.height.equalTo(8)
            }
        }
        /** 分割线 */
        let lastLable = self.viewWithTag(12) as! UILabel
        let line = UIView()
        line.backgroundColor = YCColorBlack
        line.alpha = 0.1
        self.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(lastLable).offset(45)
            make.height.equalTo(1)
        }
        let imageArray1 = ["im_data","im_ip"]
        let titleArray1 = ["流量消耗","IP地址"]
        let contentArray = ["26M",IPADRESS()]
        for i in 0..<titleArray1.count {
            /** 图标 */
            let iconImage = UIImageView()
            self.addSubview(iconImage)
            iconImage.image = UIImage(named: imageArray1[i])
            iconImage.snp.makeConstraints { (make) in
                make.top.equalTo(line.snp.bottom).offset(20+i*40)
                make.left.equalTo(22)
                make.width.equalTo(31.5/2)
                make.height.equalTo(31.5/2)
            }
            /** 标题 */
            let titLable = UILabel()
            self.addSubview(titLable)
            titLable.text = titleArray1[i]
            titLable.font = YC_FONT_PFSC_Medium(13)
            titLable.textColor = YCColorStanBlue
            titLable.snp.makeConstraints { (make) in
                make.top.equalTo(line.snp.bottom).offset(20+i*40)
                make.left.equalTo(iconImage.snp.right).offset(20)
            }
            /** 内容 */
            let contentLable = UILabel()
            self.addSubview(contentLable)
            contentLable.text = contentArray[i]
            contentLable.font = YC_FONT_PFSC_Medium(14)
            contentLable.textColor = YCColorTitleLight
            contentLable.snp.makeConstraints { (make) in
                make.top.equalTo(line.snp.bottom).offset(20+i*40)
                make.right.equalTo(-20)
            }
        }
    }
    
    func gaintInfoModel(infoModel:LYHomeModel) {
        var proLable = ""
        var progressImage = ""
        //返回的是个可选值，不一定有值，也可能是nill
        let double = Double("\(infoModel.downSpeed!)")
        //返回的double是个可选值，所以需要给个默认值或者用!强制解包
        let downFloat = CGFloat(double ?? 0)
        if downFloat<=15 {
            proLable = "1/5"
            progressImage = "stupid_level1"
        }else if downFloat>15 && downFloat<=45{
            proLable = "2/5"
            progressImage = "stupid_level2"
        }else if downFloat>45 && downFloat<=65{
            proLable = "3/5"
            progressImage = "stupid_level3"
        }else if downFloat>65 && downFloat<=65 {
            proLable = "4/5"
            progressImage = "stupid_level4"
        }else{
            proLable = "5/5"
            progressImage = "stupid_level5"
        }
        for i in 0..<3 {
            let lable = self.viewWithTag(i+100) as! UILabel
            lable.text = proLable
            let imageView = self.viewWithTag(i+1000) as! UIImageView
            imageView.image = UIImage(named: progressImage)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
