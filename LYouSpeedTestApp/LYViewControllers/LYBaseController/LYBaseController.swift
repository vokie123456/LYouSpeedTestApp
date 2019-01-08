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
    var rightView:UIButton = UIButton()
    let backButton =   UIButton(type: .custom)
    let clearButton =   UIButton(type: .custom)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarBgColor()
        self.navigationController!.navigationBar.barStyle = UIBarStyle(rawValue: 1)!
        self.view.backgroundColor = YCColorMain
        self.navigationController?.navigationBar.barTintColor = YCColorMain
        //自定义返回按钮
        leftView = UIButton(type: .custom);
        leftView.frame = CGRect(x:0, y:0, width:100, height:40)
        leftView.addTarget(self, action: #selector(backToPrevious), for: .touchUpInside)
        backButton.frame = CGRect(x:0, y:8, width:22, height:25)
        backButton.setImage(UIImage(named:"backToLeft"), for: .normal)
        backButton.addTarget(self, action: #selector(backToPrevious), for: .touchUpInside)
        leftView.addSubview(backButton)
        let leftBarBtn = UIBarButtonItem(customView: leftView)
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer.width = -15;
        self.navigationItem.leftBarButtonItems = [spacer,leftBarBtn]
        //自定义清除按钮
        rightView = UIButton(type: .custom);
        rightView.frame = CGRect(x:Main_Screen_Width-100, y:0, width:100, height:40)
        rightView.addTarget(self, action: #selector(clearButtonClick), for: .touchUpInside)
        clearButton.frame = CGRect(x:70, y:5, width:30, height:30)
        clearButton.setImage(UIImage(named:"ic_delete"), for: .normal)
        clearButton.setImage(UIImage(named:"ic_delete"), for: [.normal,.highlighted])
        clearButton.addTarget(self, action: #selector(clearButtonClick), for: .touchUpInside)
        rightView.addSubview(clearButton)
        rightView.isHidden = true
        let rightBarBtn = UIBarButtonItem(customView: rightView)
        //用于消除右边空隙，要不然按钮顶不到最前面
        let spacer1 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer1.width = 0;
        self.navigationItem.rightBarButtonItems = [spacer1,rightBarBtn]
        
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
    
    //清除按钮点击响应
    @objc func clearButtonClick(){
    }
    
    
}
