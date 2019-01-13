//
//  LYResultHeadView.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/2.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

class LYResultHeadView: UIView {
    var dateTitlelable = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI(){
        dateTitlelable.text = "12月16日"
        dateTitlelable.font = YC_FONT_PFSC_Medium(18)
        dateTitlelable.textColor = YCColorBlack
        dateTitlelable.frame = CGRect(x: 0, y: -5, width: 100, height: 40)
        self.addSubview(dateTitlelable)
    }

}
