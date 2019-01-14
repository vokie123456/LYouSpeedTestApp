//
//  LYScoreVeiw.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/29.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit

class LYScoreVeiw: UIView {
    var closeBlock:(()->Void)?
    var selStarBlock:(()->Void)?

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
        bgView.layer.cornerRadius = 15
        bgView.backgroundColor = YCColorWhite
        bgView.frame = CGRect(x: 60, y: 0, width: Main_Screen_Width-120, height: 130)
        bgView.center.y = Main_Screen_Height/2-10
        self.addSubview(bgView)

        let titlelabel = UILabel()
        titlelabel.text = "您对最近几次测速满意吗？"
        titlelabel.font = YC_FONT_PFSC_Medium(13)
        titlelabel.textColor = YCColorBlack
        titlelabel.alpha = 0.8
        titlelabel.textAlignment = NSTextAlignment.center
        bgView.addSubview(titlelabel)
        titlelabel.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(15)
        }
        
        let line = UIView()
        line.backgroundColor = YCColorGray
        bgView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(titlelabel.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        
        let indexW:Int = Int((Main_Screen_Width-200)/4)-5
        for i in 0..<5 {
            let startBtn = UIButton()
            startBtn.setImage(UIImage(named:"starEmpty"), for: .normal)
            startBtn.tag = i+10
            bgView.addSubview(startBtn)
            startBtn.snp.makeConstraints { (make) in
                make.left.equalTo(40+i*indexW)
                make.top.equalTo(line.snp.bottom).offset(10)
                make.width.equalTo(20)
                make.height.equalTo(20)
            }
            if(startBtn.tag==14){
                startBtn.setImage(UIImage(named:"starSelected"), for: .normal)
            }
            startBtn.addTarget(self, action: #selector(startBtnClick), for: .touchUpInside)
        }
        
        let line1 = UIView()
        line1.backgroundColor = YCColorGray
        bgView.addSubview(line1)
        line1.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(line.snp.bottom).offset(40)
            make.height.equalTo(1)
        }
        /** 关闭按钮 */
        let closeBtn = UIButton()
        closeBtn.setTitle("以后", for: .normal)
        closeBtn.setTitleColor(YCColorStanBlue, for: .normal)
        closeBtn.titleLabel?.font = YC_FONT_PFSC_Medium(13)
        bgView.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-5)
            make.height.equalTo(30)
        }
        closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
    }
    
    @objc func closeBtnClick() {
        closeBlock!()
    }
    @objc func startBtnClick() {
        selStarBlock!()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
