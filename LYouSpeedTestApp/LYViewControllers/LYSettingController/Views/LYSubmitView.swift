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
    var selSubmitBlock:(()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        creatUI()
    }
    func creatUI(){
        let titlelabel = UILabel()
        titlelabel.text = "您为什么不喜欢测速大师？"
        titlelabel.textAlignment = NSTextAlignment.center
        titlelabel.font = YC_FONT_PFSC_Medium(16)
        titlelabel.textColor = UIColor.gray
        self.addSubview(titlelabel)
        titlelabel.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(22)
        }
        let titleArr = ["广告太多","测速结果不准确","不喜欢app的设计","其他原因"]
        for i in 0..<4 {
            let submitBtn = UIButton()
            submitBtn.tag = i+10
            submitBtn.setImage(UIImage(named: "icon_question"), for: .normal)
            submitBtn.setImage(UIImage(named: "icon_question_selected"), for: .highlighted)
            submitBtn.setImage(UIImage(named: "icon_question_selected"), for: .selected)
            submitBtn.setImage(UIImage(named: "icon_question_selected"), for: [.highlighted, .selected])
            submitBtn.setTitle(titleArr[i], for: .normal)
            submitBtn.setTitleColor(UIColor.gray, for: .normal)
            submitBtn.titleLabel?.font = YC_FONT_PFSC_Medium(14)
            submitBtn.contentHorizontalAlignment = .left
            submitBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0);
            self.addSubview(submitBtn)
            submitBtn.snp.makeConstraints { (make) in
                make.top.equalTo(titlelabel.snp.bottom).offset(10+i*35)
                make.left.equalTo(50)
                make.right.equalTo(-30)
                make.height.equalTo(35)
            }
            submitBtn.addTarget(self, action: #selector(selBtnClick(_:)), for: .touchUpInside)
        }
        /** 取消/提交 */
        
    }
    
    @objc func selBtnClick(_ button:UIButton) {
        for i in 0..<4 {
            let btn:UIButton = self.viewWithTag(i+10) as! UIButton
            btn.isSelected = false
        }
        button.isSelected = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
