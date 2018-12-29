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
        creatUI()
    }
    func creatUI(){
        /** 背景框 */
        let bgImageView = UIImageView()
        bgImageView.layer.masksToBounds = true
        bgImageView.isUserInteractionEnabled = true
        bgImageView.layer.cornerRadius = 10
        bgImageView.frame = CGRect(x: 0, y: 0, width: Main_Screen_Width-80, height: 170)
        bgImageView.image = UIImage(named:"image_gradualColor")
        self.addSubview(bgImageView)
        /** 关闭按钮 */
        let closeBtn = UIButton()
        closeBtn.setImage(UIImage(named:"close_gray"), for: .normal)
        bgImageView.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(10)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        let xinView = UIImageView()
        xinView.layer.masksToBounds = true
        xinView.image = UIImage(named:"loveIcon_right")
        bgImageView.addSubview(xinView)
        xinView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(40)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        let titlelabel = UILabel()
        titlelabel.text = "您对最近几次测速满意吗？"
        titlelabel.font = YC_FONT_PFSC_Medium(16)
        titlelabel.textColor = UIColor.white
        bgImageView.addSubview(titlelabel)
        titlelabel.snp.makeConstraints { (make) in
            make.left.equalTo(xinView.snp.right).offset(10)
            make.top.equalTo(45)
            make.right.equalTo(-20)
        }
        let indexW:Int = Int((Main_Screen_Width-140-5*35)/4)+35
        for i in 0..<5 {
            let startBtn = UIButton()
            startBtn.setImage(UIImage(named:"starEmpty"), for: .normal)
            startBtn.tag = i+10
            bgImageView.addSubview(startBtn)
            startBtn.snp.makeConstraints { (make) in
                make.left.equalTo(30+i*indexW)
                make.top.equalTo(titlelabel.snp.bottom).offset(35)
                make.width.equalTo(35)
                make.height.equalTo(35)
            }
            if(startBtn.tag==14){
                startBtn.setImage(UIImage(named:"starSelected"), for: .normal)
            }
            startBtn.addTarget(self, action: #selector(startBtnClick), for: .touchUpInside)
        }
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
