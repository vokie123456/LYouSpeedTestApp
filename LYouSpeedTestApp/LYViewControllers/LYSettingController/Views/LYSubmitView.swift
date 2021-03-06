//
//  LYSubmitView.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/29.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit

class LYSubmitView: UIView {
    var closeBlock:(()->Void)?
    var selSubmitBlock:((_ title:NSString)->Void)?
    var submitBlock:((_ tag:NSInteger)->Void)?
    
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
        bgView.frame = CGRect(x: 60, y: 0, width: Main_Screen_Width-120, height: 240)
        bgView.center.y = Main_Screen_Height/2-20
        self.addSubview(bgView)
        
        let titlelabel = UILabel()
        titlelabel.text = "您为什么不喜欢TX SPEED ?"
        titlelabel.textAlignment = NSTextAlignment.center
        titlelabel.font = YC_FONT_PFSC_Medium(16)
        titlelabel.textColor = UIColor.gray
        bgView.addSubview(titlelabel)
        titlelabel.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(22)
        }
        let titleArr = ["广告太多","测速结果不准确","不喜欢app的设计","其他原因"]
        for i in 0..<4 {
            let selBtn = UIButton()
            selBtn.tag = i+10
            selBtn.setImage(UIImage(named: "icon_question"), for: .normal)
            selBtn.setImage(UIImage(named: "icon_question_selected"), for: .highlighted)
            selBtn.setImage(UIImage(named: "icon_question_selected"), for: .selected)
            selBtn.setImage(UIImage(named: "icon_question_selected"), for: [.highlighted, .selected])
            selBtn.setTitle(titleArr[i], for: .normal)
            selBtn.setTitleColor(UIColor.gray, for: .normal)
            selBtn.titleLabel?.font = YC_FONT_PFSC_Medium(14)
            selBtn.contentHorizontalAlignment = .left
            selBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0);
            bgView.addSubview(selBtn)
            selBtn.snp.makeConstraints { (make) in
                make.top.equalTo(titlelabel.snp.bottom).offset(10+i*35)
                make.left.equalTo(50)
                make.right.equalTo(-30)
                make.height.equalTo(35)
            }
            selBtn.addTarget(self, action: #selector(selBtnClick(_:)), for: .touchUpInside)
        }
        let submitArr = ["提交","取消"]
        /** 取消/提交 */
        for i in 0..<2 {
            let submitBtn = UIButton()
            submitBtn.tag = i+100
            submitBtn.setTitle(submitArr[i], for: .normal)
            submitBtn.setTitleColor(YCColorStanBlue, for: .normal)
            submitBtn.titleLabel?.font = YC_FONT_PFSC_Medium(18)
            submitBtn.contentHorizontalAlignment = .center
            bgView.addSubview(submitBtn)
            submitBtn.snp.makeConstraints { (make) in
                make.bottom.equalTo(0)
                make.right.equalTo(-20-i*60)
                make.width.equalTo(60)
                make.height.equalTo(50)
            }
            submitBtn.addTarget(self, action: #selector(submitBtn(_:)), for: .touchUpInside)
            
        }
    }
    
    @objc func selBtnClick(_ button:UIButton) {
        for i in 0..<4 {
            let btn:UIButton = self.viewWithTag(i+10) as! UIButton
            btn.isSelected = false
        }
        button.isSelected = true
        selSubmitBlock!(button.currentTitle! as NSString)
    }
    
    @objc func submitBtn(_ button:UIButton) {
        submitBlock!(button.tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
