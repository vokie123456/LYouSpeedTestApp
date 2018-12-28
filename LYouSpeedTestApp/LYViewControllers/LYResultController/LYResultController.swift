//
//  LYResultController.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/27.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit

class LYResultController: LYBaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButton.setImage(UIImage(named:""), for: .normal)
        self.backButton.setTitle("结果", for: .normal)
        self.backButton.frame.size.width = 42
    }
    
}
