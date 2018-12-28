//
//  LYBaseController.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/27.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit

class LYBaseController: UIViewController {
    var leftView:UIButton = UIButton()
    let backButton =   UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarBgColor()
        self.navigationController!.navigationBar.barStyle = UIBarStyle(rawValue: 1)!
        self.view.backgroundColor = YCColorMain
        //自定义返回按钮
        leftView = UIButton(type: .custom);
        leftView.frame = CGRect(x:0, y:0, width:100, height:40)
        leftView.addTarget(self, action: #selector(backToPrevious), for: .touchUpInside)
        backButton.frame = CGRect(x:0, y:6, width:22, height:25)
        backButton.setImage(UIImage(named:"backToLeft"), for: .normal)
        backButton.addTarget(self, action: #selector(backToPrevious), for: .touchUpInside)
        leftView.addSubview(backButton)
        let leftBarBtn = UIBarButtonItem(customView: leftView)
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer.width = -15;
        self.navigationItem.leftBarButtonItems = [spacer,leftBarBtn]
    }
    
    //MARK:=======设置NavBar背景色
    func setNavBarBgColor() {
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = YCColorMain
        let dict = [NSAttributedString.Key.foregroundColor:YCColorWhite]
        navBar.titleTextAttributes = dict
        self.navigationController!.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    //返回按钮点击响应
    @objc func backToPrevious(){
        self.navigationController!.popViewController(animated: true)
    }
}
