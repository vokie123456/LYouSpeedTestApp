//
//  LYBuyInfoView.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/2.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

class LYBuyInfoView: UIView {
    var selBuyMemBlock:(()->Void)?
    var recoverBuyMemBlock:(()->Void)?
    var selYsXyMemBlock:(()->Void)?
    var selServerMemBlock:(()->Void)?
    let freeButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = YCColorGray
        creatUI()
    }
    
    func creatUI(){
        let mainScrollView = UIScrollView()
        mainScrollView.bounces = true
        mainScrollView.showsHorizontalScrollIndicator = false //不显示水平拖地的条
        mainScrollView.showsVerticalScrollIndicator = false //不显示垂直拖动的条
        mainScrollView.backgroundColor = YCColorGray
        self.addSubview(mainScrollView)
        mainScrollView.contentSize = CGSize(width: Main_Screen_Width, height: 667+150)
        mainScrollView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(0);
            make.height.equalTo(667);
        }
        /** 标题 */
        let titleLable = UILabel()
        mainScrollView.addSubview(titleLable)
        titleLable.text = "即刻升级,尊享特权"
        titleLable.font = YC_FONT_PFSC_Medium(15)
        titleLable.textColor = gof_ColorWithHex(0x444444)
        titleLable.textAlignment = NSTextAlignment.center
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(Main_Screen_Width)
            make.top.equalTo(30)
        }
        /** 购买会员 */
        let dayArray = ["极速：最好用的手机网络助手、非凡软件大师。","无限制：不限时，一键PING，上网工具。","无广告：使用的过程中，不被打扰。"]
        for i in 0..<3 {
            let selButton = LYBuyButton()
            mainScrollView.addSubview(selButton)
            selButton.tag = i+10
            selButton.dayLable.text = dayArray[i]
            selButton.snp.makeConstraints { (make) in
                make.left.equalTo(30)
                make.width.equalTo(Main_Screen_Width-60)
                make.top.equalTo(titleLable.snp.bottom).offset(22+i*100)
                make.height.equalTo(80)
            }
        }

        let lastButton =  self.viewWithTag(12) as? LYBuyButton
        /**  恢复购买 */
        let recoveryBuy = UILabel()
        recoveryBuy.text = "恢复购买"
        recoveryBuy.font = YC_FONT_PFSC_Medium(15)
        recoveryBuy.textAlignment = NSTextAlignment.center
        recoveryBuy.textColor = gof_ColorWithHex(0x444444)
        recoveryBuy.isUserInteractionEnabled = true
        mainScrollView.addSubview(recoveryBuy)
        recoveryBuy.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(lastButton!.snp.bottom).offset(25)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(recoverGestureAction))
        tapGesture.numberOfTapsRequired = 1
        recoveryBuy.addGestureRecognizer(tapGesture)
        /** 免费试用 */
        freeButton.layer.cornerRadius = 5
        freeButton.backgroundColor = YCColorStanBlue
        freeButton.setTitle("免费试用", for: .normal)
        freeButton.titleLabel?.font = YC_FONT_PFSC_Medium(15)
        freeButton.setTitleColor(YCColorWhite, for: .normal)
        self.addSubview(freeButton)
        freeButton.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(recoveryBuy.snp.bottom).offset(20)
            make.right.equalTo(-20)
            make.height.equalTo(45)
        }
        freeButton.addTarget(self, action: #selector(freeButton(_:)), for: .touchUpInside)
        /** 试用说明 */
        let priceLable = UILabel()
        priceLable.text = "￡32.99/yearly after 7 days free trail!"
        priceLable.font = YC_FONT_PFSC_Medium(12)
        priceLable.textAlignment = NSTextAlignment.center
        priceLable.textColor = YCColorTitleLight
        priceLable.isUserInteractionEnabled = true
        mainScrollView.addSubview(priceLable)
        priceLable.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(freeButton.snp.bottom).offset(10)
        }
        /**  订阅信息 */
//        let infoLable = UILabel()
//        infoLable.text = "订阅信息"
//        infoLable.font = YC_FONT_PFSC_Medium(25/2)
//        infoLable.textColor = gof_ColorWithHex(0x444444)
//        infoLable.isUserInteractionEnabled = true
//        mainScrollView.addSubview(infoLable)
//        infoLable.snp.makeConstraints { (make) in
//            make.left.equalTo(30)
//            make.top.equalTo(freeButton.snp.bottom).offset(60)
//        }
//        /**  订阅描述 */
//        let infoContentLable = UILabel()
//        infoContentLable.text = "SpeedTest 升级到高级版\n\n- 订阅时长:1个月，6个月，或12个月\n- 价格和单位:CN￥6.00/月,CN￥24.00/6个月,或CN￥30.00/12个月\n\n- 可以在iTunes和App Store Apple ID设置中随时取消订阅。所有价格均包含适用的当地销售税。\n- 付款将在确认购买时从iTunes账户中扣除。\n- 订阅会自动续订，除非在当前期间结束前至少24小时关闭自动续订。\n- 账户将在当前期间结束前24小时内收取续订费用，并确定续订费用。\n- 订阅可由用户管理，并且可以通过转到以下方式关闭自动续订购买后用户的账户设置。\n- 在有效订阅期间不允许取消当前订阅。"
//        infoContentLable.font = YC_FONT_PFSC_Medium(8)
//        infoContentLable.textColor = gof_ColorWithHex(0x444444)
//        infoContentLable.numberOfLines = 0
//        infoContentLable.isUserInteractionEnabled = true
//        mainScrollView.addSubview(infoContentLable)
//        infoContentLable.snp.makeConstraints { (make) in
//            make.left.equalTo(30)
//            make.width.equalTo(Main_Screen_Width-60)
//            make.top.equalTo(infoLable.snp.bottom).offset(15)
//        }
        /** 购买协议 */
        let buyDislable = WPHotspotLabel()
        buyDislable.font = YC_FONT_PFSC_Medium(12)
        buyDislable.numberOfLines = 0
//        buyDislable.lineBreakMode = NSLineBreakMode.byCharWrapping
        buyDislable.textColor = YCColorTitleLight
        buyDislable.textAlignment = NSTextAlignment.left
        mainScrollView.addSubview(buyDislable)
        buyDislable.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.width.equalTo(Main_Screen_Width-50)
            make.top.equalTo(freeButton.snp.bottom).offset(30)
            make.height.equalTo(200)
        }
        let recoverStyle = ["body":YC_FONT_PFSC_Medium(12),"pro1":WPAttributedStyleAction.styledAction(action: {
            print("=====Terms of use")
            self.selYsXyMemBlock!()
        }),"pro2":WPAttributedStyleAction.styledAction(action: {
            print("=====Privacy Policy")
            self.selServerMemBlock!()
        }),"u":[YCColorTitleLight, [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]],"link":YCColorTitleLight] as [String : Any]
        buyDislable.attributedText = "This enables a 7 day free trial,followed by a subscription to TX Speed Premium for £32.99/yearly.By joining, you accept our <pro1><u>Terms of use</u></pro1> and <pro2><u>Privacy Policy</u></pro2>.This subscription auto-renews at the and of each year term at £32.99,unless cancalled 24-hours in advance.The subscription fee is charged to your iTunes account at confirmation of purchase.You may manage your subscription and turn off auto-renewal by going to your Settings.No cancellation of the current subscription is allowed during active period.".attributedString(withStyleBook: recoverStyle)
    }
    
    @objc func freeButton(_ button:UIButton) {
        selBuyMemBlock!()
    }
    
    @objc fileprivate func recoverGestureAction(action:UITapGestureRecognizer){
        recoverBuyMemBlock!()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
