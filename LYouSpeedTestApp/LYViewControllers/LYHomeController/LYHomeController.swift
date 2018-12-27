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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(bgImageView)
        self.view.addSubview(headView)
        headView.snp.makeConstraints { (make) in
            make.top.equalTo(StatusBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(kWidth(R: 180))
        }
    }
    
    //MARK:=====添加背景图
    private lazy var bgImageView:UIImageView = {
        let  bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Main_Screen_Width, height: Main_Screen_Height))
        bgImageView.image = UIImage(named:"im_bg_home")
        return bgImageView
    }()
}
