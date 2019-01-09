//
//  LYBuyMemberController.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/28.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit

class LYBuyMemController: LYBaseController,YQInAppPurchaseToolDelegate {

    var IAPTool = YQInAppPurchaseTool()
    let infoView = LYBuyInfoView()
    override func viewDidLoad() {
        super.viewDidLoad()
        /** 初始化内购 */
        //获取单例
        self.IAPTool = YQInAppPurchaseTool.default()
        //设置代理
        self.IAPTool.delegate = self;
        //购买后，向苹果服务器验证一下购买结果。默认为YES。不建议关闭
        self.IAPTool.checkAfterPay = false;
        
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
            /** 发起内购 */
            //向苹果询问哪些商品能够购买
            self.IAPTool.requestProducts(withProductArray:[APPSTORYBUYID])
            LYouLoadingView.show()
        }
        infoView.recoverBuyMemBlock = {() in
            print("恢复购买商品===")
            self.IAPTool.restorePurchase()
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
