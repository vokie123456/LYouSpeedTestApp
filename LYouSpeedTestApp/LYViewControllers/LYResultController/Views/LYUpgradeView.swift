//
//  LYUpgradeView.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/2.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

class LYUpgradeView: UIView {
    var updateBlock:(()->Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI(){
        let upgradeButton = UIButton()
        upgradeButton.backgroundColor = YCColorYellow
        upgradeButton.setImage(UIImage(named: "updateIcon"), for: .normal)
        upgradeButton.setImage(UIImage(named: "updateIcon"), for: [.normal,.highlighted])
        upgradeButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        upgradeButton.setTitle("升级到高级版", for: .normal)
        upgradeButton.setTitleColor(YCColorMain, for: .normal)
        self.addSubview(upgradeButton)
        upgradeButton.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(50)
        }
        upgradeButton.addTarget(self, action: #selector(upgradeButton(_:)), for: .touchUpInside)
    }
    @objc func upgradeButton(_ button:UIButton) {
        updateBlock!()
    }
}