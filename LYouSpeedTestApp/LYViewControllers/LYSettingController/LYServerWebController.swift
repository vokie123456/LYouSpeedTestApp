//
//  LYServerWebController.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/28.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit

class LYServerWebController: LYBaseH5Controller {
    var titleStr:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if (titleStr=="1") {
            self.startLoadWithTitle(title: "隐私协议", url: "http://www.sina.com")
        }else{
            self.startLoadWithTitle(title: "服务条款", url: "https://www.baidu.com")
        }
    }
    
}
