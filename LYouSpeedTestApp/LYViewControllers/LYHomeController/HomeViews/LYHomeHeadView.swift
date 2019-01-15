//
//  LYHomeHeadView.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/27.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit
import SnapKit

class LYHomeHeadView: UIView {
    let titleLable = UILabel()
    let upLable = UILabel()   /** 上传速度 */
    let downLable = UILabel() /** 下载速度 */

    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
    }
    //MARK:===创建视图
    func creatUI(){
        /** 上传下载 */
        let showSpeedBgView = UIImageView()
        showSpeedBgView.image = UIImage(named: "img_currentSpeedBackground")
        self.addSubview(showSpeedBgView)
        showSpeedBgView.alpha = 1
        showSpeedBgView.snp.makeConstraints { (make) in
            make.top.equalTo(90)
            make.right.equalTo(22)
            make.width.equalTo(115)
            make.height.equalTo(55)
        }
        let upImageView = UIImageView()
        showSpeedBgView.addSubview(upImageView)
        upImageView.image = UIImage(named:"icon_up")
        upImageView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(20)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        let downImageView = UIImageView()
        showSpeedBgView.addSubview(downImageView)
        downImageView.image = UIImage(named:"icon_down")
        downImageView.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.left.equalTo(20)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        showSpeedBgView.addSubview(upLable)
        upLable.text = "0Mbps"
        upLable.font = YC_FONT_PFSC_Medium(12)
        upLable.textColor = YCColorTitleLight
        upLable.snp.makeConstraints { (make) in
            make.top.equalTo(4)
            make.left.equalTo(downImageView).offset(22)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(25)
        }
        showSpeedBgView.addSubview(downLable)
        downLable.text = "0Mbps"
        downLable.font = YC_FONT_PFSC_Medium(12)
        downLable.textColor = YCColorTitleLight
        downLable.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.left.equalTo(downImageView).offset(22)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(25)
        }
        let titleArray = ["延时","下载","上传"]
        let imageArray = ["im_ping_wait","im_download_wait","im_upload_wait"]
        let dateArray = ["1","29.4","11"]
        let danweiArray = ["ms","Mbps","Mbps"]
        let indexW = (Int)(Main_Screen_Width)/3

        for i in 0..<titleArray.count {
            /** 标题 */
            let titleLable = UILabel()
            self.addSubview(titleLable)
            titleLable.text = titleArray[i]
            titleLable.font = YC_FONT_PFSC_Medium(14)
            titleLable.textAlignment = NSTextAlignment.center
            titleLable.textColor = YCColorTitleLight
            var width = 50
            if(i==0){
                width = 50
            }else if(i==1){
                width = Int((Main_Screen_Width-220)/2)+90
            }else{
                width = Int(Main_Screen_Width-90)
            }
            titleLable.snp.makeConstraints { (make) in
                make.top.equalTo(self).offset(20)
                make.left.equalTo(width)
                make.width.equalTo(40)
            }
            /** 图片 */
            let imageView = UIImageView()
            imageView.image = UIImage(named:imageArray[i])
            self.addSubview(imageView)
            imageView.tag = i+100
            imageView.snp.makeConstraints { (make) in
                make.top.equalTo(titleLable.snp.bottom).offset(5)
                make.left.equalTo(width+10)
                make.width.equalTo(20)
                make.height.equalTo(20)
            }
            /** 测试数据 */
            let dateLable = UILabel()
            self.addSubview(dateLable)
            dateLable.text = dateArray[i]
            dateLable.font = YC_FONT_PFSC_Medium(17)
            dateLable.textAlignment = NSTextAlignment.center
            dateLable.textColor = YCColorTitleLight
            dateLable.tag = i+1000
            dateLable.isHidden = true
            dateLable.snp.makeConstraints { (make) in
                make.top.equalTo(titleLable.snp.bottom).offset(5)
                make.left.equalTo(i*indexW)
                make.width.equalTo(indexW)
            }
            if(i==0){
                dateLable.snp.updateConstraints { (make) in
                    make.left.equalTo(5+i*indexW)
                }
            }
            if(i==2){
                dateLable.snp.updateConstraints { (make) in
                    make.left.equalTo(i*indexW-6)
                }
            }
            /** 单位 */
            let danweiLable = UILabel()
            self.addSubview(danweiLable)
            danweiLable.text = danweiArray[i]
            danweiLable.font = YC_FONT_PFSC_Medium(14)
            danweiLable.textAlignment = NSTextAlignment.center
            danweiLable.textColor = YCColorTitleLight
            danweiLable.tag = i+10000
            danweiLable.isHidden = true
            danweiLable.snp.makeConstraints { (make) in
                make.top.equalTo(dateLable.snp.bottom).offset(0)
                make.left.equalTo(i*indexW)
                make.width.equalTo(indexW)
            }
            if(i==0){
                danweiLable.snp.updateConstraints { (make) in
                    make.left.equalTo(6+i*indexW)
                }
            }
            if(i==2){
                danweiLable.snp.updateConstraints { (make) in
                    make.left.equalTo(i*indexW-6)
                }
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
