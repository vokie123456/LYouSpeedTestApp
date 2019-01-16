//
//  LYFreeTipsView.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/14.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

class LYFreeTipsView: UIView {
    let freelabel = UILabel()

    var closeBlock:(()->Void)?
    var selUpdateBlock:(()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.5) // 设置半透明颜色
        creatUI()
    }
    func creatUI(){
        /** 背景框 */
        let bgView = UIView()
        bgView.layer.masksToBounds = true
        bgView.isUserInteractionEnabled = true
        bgView.layer.cornerRadius = 10
        bgView.backgroundColor = YCColorWhite
        bgView.frame = CGRect(x: 60, y: 0, width: Main_Screen_Width-120, height: 280)
        bgView.center.y = Main_Screen_Height/2-10
        self.addSubview(bgView)
        /** 关闭按钮 */
        let closeBtn = UIButton()
        closeBtn.setImage(UIImage(named: "close_gray"), for: .normal)
        bgView.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.right.equalTo(-15)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        /** 图标 */
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "icon_crown")
        bgView.addSubview(iconImage)
        iconImage.snp.makeConstraints { (make) in
            make.top.equalTo(35)
            make.left.equalTo(50)
            make.width.equalTo(26)
            make.height.equalTo(24)
        }
        let titlelabel = UILabel()
        titlelabel.text = "高级版"
        titlelabel.font = YC_FONT_PFSC_Medium(29)
        titlelabel.textColor = YCColorStanBlue
        titlelabel.textAlignment = NSTextAlignment.center
        bgView.addSubview(titlelabel)
        titlelabel.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(25)
        }
        let imageArray = ["buyAdboa0","buyAdboa1","buyAdboa2"]
        let titleArray = ["极速","无限测速","无广告"]
        let picWidth = (Int)(Main_Screen_Width-150-57*3)/2
        let disWidth = (Int)(Main_Screen_Width-120)/3

        for i in 0..<3 {
            /** 图片 */
            let imageView = UIImageView()
            imageView.image = UIImage(named:imageArray[i])
            bgView.addSubview(imageView)
            imageView.tag = i+100
            imageView.snp.makeConstraints { (make) in
                make.top.equalTo(titlelabel.snp.bottom).offset(25)
                make.left.equalTo(15+i*(picWidth+57))
                make.width.equalTo(57)
                make.height.equalTo(57)
            }
            if imageView.tag==101{
                imageView.snp.updateConstraints { (make) in
                    make.top.equalTo(titlelabel.snp.bottom).offset(15)
                    make.left.equalTo(15+i*(picWidth+50))
                    make.width.equalTo(70)
                    make.height.equalTo(71)
                }
            }
            /** 标题 */
            let disLable = UILabel()
            bgView.addSubview(disLable)
            disLable.text = titleArray[i]
            disLable.tag = i+1000
            disLable.font = YC_FONT_PFSC_Medium(9)
            disLable.textAlignment = NSTextAlignment.center
            disLable.textColor = YCColorTitleLight
            disLable.snp.makeConstraints { (make) in
                make.top.equalTo(imageView.snp.bottom).offset(10)
                make.left.equalTo(i * disWidth)
                make.width.equalTo(disWidth)
            }
            if disLable.tag==1001{
                disLable.snp.makeConstraints { (make) in
                    make.top.equalTo(imageView.snp.bottom).offset(8)
                }
            }
        }
        /** 即可升级 */
        let updateButton = UIButton()
        bgView.addSubview(updateButton)
        updateButton.layer.cornerRadius = 36/2
        updateButton.setTitle("即可升级", for: .normal)
        updateButton.titleLabel?.font = YC_FONT_PFSC_Medium(20)
        updateButton.setTitleColor(YCColorWhite, for: .normal)
        updateButton.backgroundColor = YCColorStanBlue
        updateButton.snp.makeConstraints { (make) in
            make.top.equalTo(titlelabel.snp.bottom).offset(135)
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.width.equalTo(36)
        }
        updateButton.addTarget(self, action: #selector(updateButtonClick), for: .touchUpInside)
        /** 剩余免费次数 */
        freelabel.text = "今日剩余免费次数: 5"
        freelabel.font = YC_FONT_PFSC_Medium(11)
        freelabel.textColor = YCColorTitleLight
        freelabel.textAlignment = NSTextAlignment.center
        bgView.addSubview(freelabel)
        freelabel.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(-10)
        }
        
    }
    @objc func closeBtnClick() {
        closeBlock!()
    }
    @objc func updateButtonClick() {
        selUpdateBlock!()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
