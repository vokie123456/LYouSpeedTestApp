//
//  LYHomeController.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/27.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit

class LYHomeController: LYBaseController {
    let headView = LYHomeHeadView()
    var currenProgressView = LYCycleProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(bgImageView)
        self.view.addSubview(headView)
        headView.snp.makeConstraints { (make) in
            make.top.equalTo(StatusBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(kWidth(R: 180))
        }
        /** 创建进度条 */
        let progressView = LYCycleProgressView(frame: CGRect(x: 0, y: 0, width: Main_Screen_Width/3*2, height: Main_Screen_Width/3*2))
        progressView.center.x = self.view.center.x
        progressView.center.y = self.view.center.y+20
        progressView.progress = 0.3
        self.view.addSubview(progressView)
        currenProgressView = progressView
        /** 开始按钮 */
        let startButton = UIButton()
        self.view.addSubview(startButton)
        startButton.layer.borderWidth = 1
        startButton.layer.masksToBounds = true
        startButton.layer.borderColor = YCColorWhite.cgColor
        startButton.layer.cornerRadius = 25
        startButton.setTitle("开始", for: .normal)
        startButton.titleLabel?.font = YC_FONT_PFSC_Medium(20)
        startButton.setBackgroundImage(UIImage.init(named: "ic_glassButton"), for: .normal)
        startButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(-SafeBottomMargin-50)
            make.left.equalTo(80)
            make.right.equalTo(-80)
            make.height.equalTo(50)
        }
        startButton.addTarget(self, action: #selector(startButtonClick), for: .touchUpInside)
    }
    
    @objc private func startButtonClick()  {
        currenProgressView.progress = 0.6
    }
    
    
    //MARK:=====添加背景图
    private lazy var bgImageView:UIImageView = {
        let  bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Main_Screen_Width, height: Main_Screen_Height))
        bgImageView.image = UIImage(named:"im_bg_home")
        return bgImageView
    }()

}
