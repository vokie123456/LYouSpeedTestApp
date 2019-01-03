//
//  LYResultDetailController.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/2.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

class LYResultDetailController: LYBaseController {
    var shareRightView:UIButton = UIButton()
    let shareButton =   UIButton(type: .custom)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Wi-Fi:LYGames-5G"
        let tlabel = UILabel(frame: CGRect(x: 0, y: 0, width: Main_Screen_Width, height: 30))
        tlabel.text = navigationItem.title
        tlabel.textColor = UIColor.white
        if let font = UIFont(name: "Helvetica-Bold", size: 30.0) {
            tlabel.font = font
        }
        tlabel.backgroundColor = UIColor.clear
        tlabel.adjustsFontSizeToFitWidth = true
        self.navigationItem.titleView = tlabel
        backButton.frame.origin.y = 12
        //自定义分享按钮
        shareRightView = UIButton(type: .custom);
        shareRightView.frame = CGRect(x:Main_Screen_Width-100, y:0, width:100, height:40)
        shareRightView.addTarget(self, action: #selector(shareButtonClick), for: .touchUpInside)
        shareButton.frame = CGRect(x:70, y:10, width:30, height:30)
        shareButton.setImage(UIImage(named:"icon_share_white"), for: .normal)
        shareButton.setImage(UIImage(named:"icon_share_white"), for: [.normal,.highlighted])
        shareButton.addTarget(self, action: #selector(shareButtonClick), for: .touchUpInside)
        shareRightView.addSubview(shareButton)
        let shareBarBtn = UIBarButtonItem(customView: shareRightView)
        //用于消除右边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                      action: nil)
        spacer.width = 0;
        self.navigationItem.rightBarButtonItems = [spacer,shareBarBtn]
    }
    //分享按钮点击响应
    @objc func shareButtonClick(){
        iOSsystemShare()
    }
    //MARK:============iOS系统分享=============
    func iOSsystemShare() {
        let textToShare = "我正在使用全网测"
        let imageToShare = UIImage(named: "shareImage")
        let urlToShare = URL(string: "http://www.baidu.com")
        let activityItems = [textToShare, imageToShare as Any, urlToShare as Any] as [Any]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
//        activityVC.excludedActivityTypes = [.print, .copyToPasteboard, .assignToContact, .saveToCameraRoll]
        present(activityVC, animated: true)
        activityVC.completionWithItemsHandler = { activityType, completed, returnedItems, activityError in
            if completed {
                print("completed")
            } else {
                print("cancled")
            }
        }
    }
}
