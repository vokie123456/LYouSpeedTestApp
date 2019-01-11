//
//  AppDelegate.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/26.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder,UIApplicationDelegate,UITabBarControllerDelegate {

    var window: UIWindow?
    let rootVC = LYTabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame:UIScreen.main.bounds)
        rootVC.delegate = self
        self.window?.rootViewController = rootVC
        self.window!.makeKeyAndVisible()
        IQKeyboardManager.shared.enable = true
        
        //! 数据库
        MagicalRecord.setupCoreDataStack(withStoreNamed: "LYouSpeedInfoData.sqlite")
        let docs = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).last
        //! 数据库地址
        print("docs======\(docs ?? "")")
        //! 友盟统计
        let config = UMAnalyticsConfig.sharedInstance()
        config?.appKey = "5c36c30af1f556d8be00033f"
        config?.channelId = "App Store"
        MobClick.start(withConfigure: config)
        //! 统计不同版本
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        MobClick.setAppVersion(version)
        gaintTestPoint()
        return true
    }
    
    //MARK=========获取服务器下载上传地址
    func gaintTestPoint() {
        NetworkRequest.sharedInstance.getRequest(urlString: LYTestPointURL, params: [:], success: { (json) in
            let jsonDic = JSON(json)
            let ipStr = "\(jsonDic["ip"])"
            let downstreamStr = "\(jsonDic["downstream"])"
            let upstreamStr = "\(jsonDic["upstream"])"
            UserDefaults.standard.set(ipStr, forKey:"ipAdress")
            UserDefaults.standard.set(downstreamStr, forKey:"downLoadUrl")
            UserDefaults.standard.set(upstreamStr, forKey:"upLoadUrl")
            print("ip地址=========\(IPADRESS())")
            print("下载测试=========\(DownLoadUrl())")
            print("上传测试=========\(UpLoadUrl())")
            self.isCheckIOS()
        }) { (error) in
            EasyShowTextView .showText("服务器异常!")
        }
    }
    
    //MARK=========审核开关
    func isCheckIOS() {
        NetworkRequest.sharedInstance.getRequest(urlString: LYIosSwitch, params: [:], success: { (json) in
            let jsonDic = JSON(json)
            let isCheckIos = "\(jsonDic["status"])"
             UserDefaults.standard.set(isCheckIos, forKey:"isCheckIos")
            print("审核状态=========\(ISCHECKIOS())")
            self.IsHaveBuyMenBer()
        }) { (error) in
            EasyShowTextView .showText("服务器异常!")
        }
    }
    
    //MARK=========校验是否购买会员
    func IsHaveBuyMenBer() {
        if ISHAVEBUYMEMBER()=="no" {
            return
        }
        /** 本地服务器校验 */
        let receiptURL: URL? = Bundle.main.appStoreReceiptURL
        let receiptData = try! Data(contentsOf:receiptURL!)
        var encodeStr = receiptData.base64EncodedString(options: [])
        if (encodeStr.count) == 0 {
            encodeStr = ""
        }
        let paramsDic = ["receipt-data":encodeStr,"password":SHAREKEY]
        NetworkRequest.sharedInstance.postRequest(urlString: LYIosCheck, params: paramsDic, success: { (json) in
            let jsonDic = JSON(json)
            let states = "\(jsonDic["status"])"
            UserDefaults.standard.set(states, forKey:"isHaveBuyMemBer")
            print("是否购买会员=========\(ISHAVEBUYMEMBER())")

        }) { (error) in
            EasyShowTextView.showText("服务器校验失败!")
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

