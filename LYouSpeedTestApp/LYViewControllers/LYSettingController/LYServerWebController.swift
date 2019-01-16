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
            self.startLoadWithTitle(title: "Terms of use", url: "http://bz.pk2game.com/LYspeed_term")
        }else if (titleStr=="2") {
            self.startLoadWithTitle(title: "Privacy Policy", url: "http://bz.pk2game.com/LYspeed_privacy_policy")
        }
    }
    
}
