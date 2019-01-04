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
        titleLable.textColor = YCColorBlack
        titleLable.alpha = 0.8
        titleLable.font = YC_FONT_PFSC_Medium(16)
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
            iconImage.image = UIImage(named: imageArray[i])
            iconImage.snp.makeConstraints { (make) in
                make.top.equalTo(titleLable.snp.bottom).offset(15+i*40)
                make.left.equalTo(22)
                make.width.equalTo(22)
                make.height.equalTo(22)
            }
            /** 标题 */
            let titLable = UILabel()
            self.addSubview(titLable)
            titLable.text = titleArray[i]
            titLable.tag = i+10
            titLable.font = YC_FONT_PFSC_Medium(14)
            titLable.textColor = YCColorDarkGreen
            titLable.snp.makeConstraints { (make) in
                make.top.equalTo(titleLable.snp.bottom).offset(15+i*40)
                make.left.equalTo(iconImage.snp.right).offset(20)
            }
            /** 进度条 */
            let progressLable = UILabel()
            self.addSubview(progressLable)
            progressLable.text = "3/5"
            progressLable.tag = i+100
            progressLable.font = YC_FONT_PFSC_Medium(12)
            progressLable.textColor = YCColorGray
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
                make.width.equalTo(100)
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
        let contentArray = ["43M","124.168.1.23"]
        for i in 0..<titleArray1.count {
            /** 图标 */
            let iconImage = UIImageView()
            self.addSubview(iconImage)
            iconImage.image = UIImage(named: imageArray1[i])
            iconImage.snp.makeConstraints { (make) in
                make.top.equalTo(line.snp.bottom).offset(20+i*40)
                make.left.equalTo(22)
                make.width.equalTo(22)
                make.height.equalTo(22)
            }
            /** 标题 */
            let titLable = UILabel()
            self.addSubview(titLable)
            titLable.text = titleArray1[i]
            titLable.font = YC_FONT_PFSC_Medium(14)
            titLable.textColor = YCColorDarkGreen
            titLable.snp.makeConstraints { (make) in
                make.top.equalTo(line.snp.bottom).offset(20+i*40)
                make.left.equalTo(iconImage.snp.right).offset(20)
            }
            /** 内容 */
            let contentLable = UILabel()
            self.addSubview(contentLable)
            contentLable.text = contentArray[i]
            contentLable.font = YC_FONT_PFSC_Medium(14)
            contentLable.textColor = YCColorGray
            contentLable.snp.makeConstraints { (make) in
                make.top.equalTo(line.snp.bottom).offset(20+i*40)
                make.right.equalTo(-20)
            }
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
