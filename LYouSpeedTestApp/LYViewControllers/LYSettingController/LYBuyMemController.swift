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
        let bgImage = UIImageView()
        bgImage.isUserInteractionEnabled = true
        bgImage.image = UIImage(named: "im_bg_resultCard")
        self.view.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(Main_Screen_Height)
        }
        bgImage.addSubview(infoView)
        infoView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(Main_Screen_Height)
        }
        infoView.selBuyMemBlock = {(tag:NSInteger) in
            print("选择购买商品===\(tag)")
        }
        infoView.recoverBuyMemBlock = {() in
            print("恢复购买商品===")
        }
        infoView.selYsXyMemBlock = {() in
            /** 隐私协议 */
            let serverVC = LYServerWebController()
            serverVC.titleStr = "1"
            self.navigationController?.pushViewController(serverVC, animated: true)
        }
        infoView.selServerMemBlock = {() in
            /** 服务条款 */
            let serverVC = LYServerWebController()
            serverVC.titleStr = "2"
            self.navigationController?.pushViewController(serverVC, animated: true)
        }
    }
}
