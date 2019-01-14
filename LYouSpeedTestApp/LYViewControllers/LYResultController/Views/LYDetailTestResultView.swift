//
//  LYDetailTestResultView.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/14.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

class LYDetailTestResultView: UIView {
    var resultButtonBlock:(()->Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = YCColorWhite
        creatUI()
    }
    func creatUI(){
        /** 背景图片 */
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        bgImageView.layer.masksToBounds = true
        bgImageView.image = UIImage(named: "DetailResult")
        self.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(-0)
            make.height.equalTo(85)
        }
        /** 小灯泡图片 */
        let BulbImageView = UIImageView()
        BulbImageView.isUserInteractionEnabled = true
        BulbImageView.layer.masksToBounds = true
        BulbImageView.image = UIImage(named: "BulbImage")
        bgImageView.addSubview(BulbImageView)
        BulbImageView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(10)
            make.width.equalTo(15)
            make.height.equalTo(20)
        }
        let titleLable = UILabel()
        titleLable.text = "测速结果准确吗？"
        titleLable.textColor = YCColorWhite
        titleLable.font = YC_FONT_PFSC_Medium(15)
        bgImageView.addSubview(titleLable)
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(BulbImageView.snp.right).offset(15)
            make.right.equalTo(-20)
            make.top.equalTo(12)
        }
        let resultArray = ["准确","偏低","偏高"]
        let indexW = (Int)(Main_Screen_Width-40-240)/2
        for i in 0..<3 {
            /** 结果 */
            let resultButton = UIButton()
            resultButton.layer.cornerRadius = 15
            resultButton.layer.borderWidth = 1
            resultButton.layer.borderColor = YCColorWhite.cgColor
            resultButton.setTitle(resultArray[i], for: .normal)
            resultButton.titleLabel?.font = YC_FONT_PFSC_Medium(13)
            resultButton.setTitleColor(YCColorWhite, for: .normal)
            self.addSubview(resultButton)
            resultButton.snp.makeConstraints { (make) in
                make.left.equalTo(20+i*(80+indexW))
                make.top.equalTo(titleLable.snp.bottom).offset(10)
                make.width.equalTo(80)
                make.height.equalTo(30)
            }
            resultButton.addTarget(self, action: #selector(resultButton(_:)), for: .touchUpInside)
        }
    }
    
    @objc func resultButton(_ button:UIButton) {
        resultButtonBlock!()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
