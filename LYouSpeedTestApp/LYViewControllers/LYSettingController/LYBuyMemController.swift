//
//  LYBuyMemberController.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/28.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit
import SwiftyJSON

class LYBuyMemController: LYBaseController,YQInAppPurchaseToolDelegate {

    var IAPTool = YQInAppPurchaseTool()
    let infoView = LYBuyInfoView()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MobClick.beginLogPageView("LYBuyMemController")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MobClick.endLogPageView("LYBuyMemController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /** 初始化内购 */
        //获取单例
        self.IAPTool = YQInAppPurchaseTool.default()
        //设置代理
        self.IAPTool.delegate = self;
        //购买后，向苹果服务器验证一下购买结果。默认为YES。不建议关闭
        self.IAPTool.checkAfterPay = false;
        self.view.backgroundColor = YCColorGray
        self.view.addSubview(infoView)
        self.navigationItem.title = "升级到高级版"
        infoView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(Main_Screen_Height)
        }
        /** 判断是否购买会员 */
        if ISHAVEBUYMEMBER()=="no" {
            infoView.freeButton.isEnabled = true
            infoView.freeButton.backgroundColor = YCColorStanBlue
            infoView.freeButton.setTitle("免费试用", for: .normal)
            infoView.freeButton.setTitleColor(YCColorWhite, for: .normal)
        }else{
            infoView.freeButton.isEnabled = false
            infoView.freeButton.backgroundColor = YCColorDarkLight
            infoView.freeButton.setTitle("已订阅", for: .normal)
            infoView.freeButton.setTitleColor(YCColorStanBlue, for: .normal)
        }
        infoView.selBuyMemBlock = {() in
            /** 发起内购 */
            //向苹果询问哪些商品能够购买
            self.IAPTool.requestProducts(withProductArray:[APPSTORYBUYID])
            LYouLoadingView.show()
            //友盟统计购买事件
            MobClick.event("ClickBuyMember")
        }
        infoView.recoverBuyMemBlock = {() in
            print("恢复购买商品===")
            if ISHAVEBUYMEMBER()=="no" {
                self.IAPTool.restorePurchase()
            }else{
                EasyShowTextView.showText("服务已订阅!")
            }
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
    //MARK:==========YQInAppPurchaseToolDelegate=========
    func iapToolGotProducts(_ products: NSMutableArray!) {
        //IAP工具已获得可购买的商品
        print("list=====\(String(describing: products))")
        if products.count==0 {
            EasyShowTextView.showText("无法获取商品信息")
            return
        }
        YQInAppPurchaseTool.default()?.buyProduct(APPSTORYBUYID)
    }
    func iapToolCanceld(withProductID productID: String!) {
        //支付失败/取消
        print("canceld======\(String(describing: productID))")
    }
    func iapToolBeginCheckingd(withProductID productID: String!) {
        //支付成功了，并开始向苹果服务器进行验证（若CheckAfterPay为NO，则不会经过此步骤）
        EasyShowTextView.showText("购买成功，正在验证购买")
    }
    func iapToolCheckRedundant(withProductID productID: String!) {
        //商品被重复验证了
        EasyShowTextView.showText("重复验证了")
    }
    func iapToolBoughtProductSuccessed(withProductID productID: String!, andInfo infoDic: [AnyHashable : Any]!) {
        //商品完全购买成功且验证成功了。（若CheckAfterPay为NO，则会在购买成功后直接触发此方法）
        /** 本地服务器校验 */
        let receiptURL: URL? = Bundle.main.appStoreReceiptURL
        let receiptData = try! Data(contentsOf:receiptURL!)
        var encodeStr = receiptData.base64EncodedString(options: [])
        if (encodeStr.count) == 0 {
            encodeStr = ""
        }
        let paramsDic = ["receipt-data":encodeStr,"password":SHAREKEY]
        NetworkRequest.sharedInstance.postRequest(urlString: LYIosCheck, params: paramsDic, success: { (json) in
//            let jsonDic = JSON(json)
//            let states = "\(jsonDic["status"])"
            UserDefaults.standard.set("yes", forKey:"isHaveBuyMemBer")
            print("是否购买会员=========\(ISHAVEBUYMEMBER())")
            self.infoView.freeButton.isEnabled = false
            self.infoView.freeButton.backgroundColor = YCColorDarkLight
            self.infoView.freeButton.setTitle("已订阅", for: .normal)
            self.infoView.freeButton.setTitleColor(YCColorStanBlue, for: .normal)
        }) { (error) in
            EasyShowTextView.showText("服务器校验失败!")
        }
    }
    func iapToolCheckFailed(withProductID productID: String!, andInfo infoData: Data!) {
        //商品购买成功了，但向苹果服务器验证失败了
        //2种可能：
        //1，设备越狱了，使用了插件，在虚假购买。
        //2，验证的时候网络突然中断了。（一般极少出现，因为购买的时候是需要网络的）
        EasyShowTextView.showText("验证失败了")
    }
    func iapToolRestoredProductID(_ productID: String!) {
        //恢复了已购买的商品（仅限永久有效商品）
        
    }
    func iapToolSysWrong() {
        //内购系统错误了
        EasyShowTextView.showText("内购系统出错")
    }
}
