//
//  LYBuyInfoView.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/2.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

class LYBuyInfoView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = YCColorMain
        creatUI()
    }
    
    func creatUI(){
        let mainScrollView = UIScrollView()
        mainScrollView.bounces = true
        mainScrollView.showsHorizontalScrollIndicator = false //不显示水平拖地的条
        mainScrollView.showsVerticalScrollIndicator = false //不显示垂直拖动的条
        mainScrollView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        self.addSubview(mainScrollView)
        mainScrollView.contentSize = CGSize(width: Main_Screen_Width, height: Main_Screen_Height)
        mainScrollView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(0);
            make.height.equalTo(Main_Screen_Height);
        }
        /** 标题 */
        let titleLable = UILabel()
        mainScrollView.addSubview(titleLable)
        titleLable.text = "即刻升级,尊享特权"
        titleLable.font = YC_FONT_PFSC_Medium(20)
        titleLable.textColor = YCColorWhite
        titleLable.textAlignment = NSTextAlignment.center
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(Main_Screen_Width)
            make.top.equalTo(30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
