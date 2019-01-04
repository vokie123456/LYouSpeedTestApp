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
        self.addSubview(titleLable)
        titleLable.text = "测速大师"
        titleLable.textColor = YCColorWhite
        titleLable.alpha = 0.4
        titleLable.font = YC_FONT_PFSC_Medium(20)
        titleLable.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(20)
            make.width.equalTo(100)
        }
        /** 上传下载 */
        let showSpeedBgView = UIImageView()
        showSpeedBgView.image = UIImage(named: "img_currentSpeedBackground")
        self.addSubview(showSpeedBgView)
        showSpeedBgView.alpha = 1
        showSpeedBgView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.right.equalTo(20)
            make.width.equalTo(140)
            make.height.equalTo(50)
        }
        let upImageView = UIImageView()
        showSpeedBgView.addSubview(upImageView)
        upImageView.image = UIImage(named:"icon_up")
        upImageView.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(18)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        let downImageView = UIImageView()
        showSpeedBgView.addSubview(downImageView)
        downImageView.image = UIImage(named:"icon_down")
        downImageView.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.left.equalTo(18)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        showSpeedBgView.addSubview(upLable)
        upLable.text = "0Mbps"
        upLable.font = YC_FONT_PFSC_Medium(14)
        upLable.textColor = YCColorWhite
        upLable.alpha = 0.5
        upLable.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(downImageView).offset(22)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(25)
        }
        showSpeedBgView.addSubview(downLable)
        downLable.text = "0Mbps"
        downLable.font = YC_FONT_PFSC_Medium(14)
        downLable.textColor = YCColorWhite
        downLable.alpha = 0.5
        downLable.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.left.equalTo(downImageView).offset(22)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(25)
        }
        let titleArray = ["延时","下载","上传"]
        let imageArray = ["im_ping_wait","im_download_wait","im_upload_wait"]
        for i in 0..<titleArray.count {
            /** 标题 */
            let titleLable = UILabel()
            self.addSubview(titleLable)
            titleLable.text = titleArray[i]
            titleLable.font = YC_FONT_PFSC_Medium(14)
            titleLable.textAlignment = NSTextAlignment.center
            titleLable.textColor = YCColorWhite
            titleLable.alpha = 0.4
            var width = 50
            if(i==0){
                width = 50
            }else if(i==1){
                width = Int((Main_Screen_Width-220)/2)+90
            }else{
                width = Int(Main_Screen_Width-90)
            }
            titleLable.snp.makeConstraints { (make) in
                make.top.equalTo(showSpeedBgView).offset(80)
                make.left.equalTo(width)
                make.width.equalTo(40)
                make.height.equalTo(40)
            }
            /** 图片 */
            let imageView = UIImageView()
            imageView.image = UIImage(named:imageArray[i])
            self.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.top.equalTo(showSpeedBgView).offset(125)
                make.left.equalTo(width+10)
                make.width.equalTo(20)
                make.height.equalTo(20)
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
