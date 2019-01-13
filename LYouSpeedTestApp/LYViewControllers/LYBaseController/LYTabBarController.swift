//
//  LYTabBarController.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/27.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit

class LYTabBarController: UITabBarController {
    /** 初始化数组 */
    let PicArr = ["ic_tabicon_speedtest","ic_tabicon_history","ic_tabicon_setting"]
    let PicSelectArr = ["ic_tabicon_speedtest_selected","ic_tabicon_history_selected","ic_tabicon_setting_selected"]
    let VCArray = [LYHomeController(),LYResultController(),LYSettingController()]
    //初始化数组
    var NavVCArr:[NSObject] = [NSObject]()
    var nav:LYBaseNavigationController = LYBaseNavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CreatTabBar()
    }
    
    func CreatTabBar(){
        for i in 0..<VCArray.count {
            nav = LYBaseNavigationController(rootViewController:(VCArray[i] as AnyObject as! UIViewController))
            nav.tabBarItem.tag = i
            nav.tabBarItem.image = UIImage(named:PicArr[i])
            nav.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0);
            nav.view.backgroundColor = YCColorWhite
            nav.tabBarItem.selectedImage = UIImage(named:PicSelectArr[i])
            NavVCArr.append(nav)
        }
        self.viewControllers = NavVCArr as? [UIViewController]
        //tabBar 底部工具栏背景颜色 (以下两个都行)
        self.tabBar.barTintColor = YCColorGray
        //设置 tabBar 工具栏字体颜色 (未选中  和  选中)
        self.tabBar.tintColor = YCColorGreen
        self.tabBar.isTranslucent = false
        // 自定义顶部分割线
        let lineView = UIView()
        lineView.frame = CGRect(x: 0, y: -0.5, width: Main_Screen_Width, height: 0.5)
        lineView.backgroundColor = YCColorWhite
        lineView.alpha = 0.2
        self.tabBar.insertSubview(lineView, at: 0)
    }
}
