//
//  LYBuyMemberController.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/28.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit

class LYBuyMemController: LYBaseController {

    let infoView = LYBuyInfoView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "升级到高级版"
        self.view.addSubview(infoView)
        infoView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(Main_Screen_Height)
        }
    }
}
