//
//  LYBuyInfoView.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/2.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

class LYBuyInfoView: UIView {
    var selBuyMemBlock:((_ tag:NSInteger)->Void)?
    var recoverBuyMemBlock:(()->Void)?
    var selYsXyMemBlock:(()->Void)?
    var selServerMemBlock:(()->Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = YCColorMain
        creatUI()
    }
    
    func creatUI(){
        let mainScrollView = UIScrollView()
        mainScrollView.bounces = true
        mainScrollView.showsHorizontalScrollIndicator = false //不显示水平拖地的条
        mainScrollView.showsVerticalScrollIndicator = false //不显示垂直拖动的条
        mainScrollView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        self.addSubview(mainScrollView)
        mainScrollView.contentSize = CGSize(width: Main_Screen_Width, height: 667+350)
        mainScrollView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(0);
            make.height.equalTo(667);
        }
        /** 标题 */
        let titleLable = UILabel()
        mainScrollView.addSubview(titleLable)
        titleLable.text = "即刻升级,尊享特权"
        titleLable.font = YC_FONT_PFSC_Medium(20)
        titleLable.textColor = YCColorWhite
        titleLable.textAlignment = NSTextAlignment.center
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(Main_Screen_Width)
            make.top.equalTo(30)
        }
        /** 功能 */
        let titleArr = ["无广告","每日无限测速","更精确"]
        let imageArr = ["image_removeAd_white","image_unlimitedTest_white","image_moreAccurate_white"]
        let indexW = (Int)(Main_Screen_Width-60-255)/2
        for i in 0..<3 {
            let functionImage = UIImageView()
            functionImage.image = UIImage(named: "\(imageArr[i])")
            mainScrollView.addSubview(functionImage)
            functionImage.snp.makeConstraints { (make) in
                make.left.equalTo(30+i*(85+indexW))
                make.top.equalTo(titleLable.snp.bottom).offset(35)
                make.width.equalTo(85)
                make.height.equalTo(85)
            }
            let functionLable = UILabel()
            mainScrollView.addSubview(functionLable)
            functionLable.text = titleArr[i]
            functionLable.font = YC_FONT_PFSC_Medium(13)
            functionLable.textColor = YCColorWhite
            functionLable.textAlignment = NSTextAlignment.center
            functionLable.snp.makeConstraints { (make) in
                make.centerX.equalTo(functionImage)
                make.top.equalTo(functionImage.snp.bottom).offset(10)
                make.width.equalTo(Main_Screen_Width/3)
            }
        }
        /** 购买会员 */
        let dayArray = ["1个月","6个月","12个月"]
        let disMoneyArray = ["CN￥6.00/月","CN￥4.00/月","CN￥2.50/月"]
        let moneyArray = ["CN￥6.00","CN￥24.00","CN￥30.00"]
        let oldmoneyArray = ["","CN￥36.00","CN￥72.00"]

        for i in 0..<3 {
            let selButton = LYBuyButton()
            mainScrollView.addSubview(selButton)
            selButton.tag = i+10
            selButton.dayLable.text = dayArray[i]
            selButton.dismoneyLable.text = disMoneyArray[i]
            selButton.moneyLable.text = moneyArray[i]
            selButton.oldmoneyLable.text = oldmoneyArray[i]
            selButton.snp.makeConstraints { (make) in
                make.left.equalTo(30)
                make.width.equalTo(Main_Screen_Width-60)
                make.top.equalTo(titleLable.snp.bottom).offset(195+i*70)
                make.height.equalTo(50)
            }
            if(selButton.tag==10){
                selButton.moneyLable.snp.updateConstraints { (make) in
                    make.top.equalTo(12);
                }
            }
            if(selButton.tag==12){
                selButton.bgView.image = UIImage(named: "image_gradualColor")
                selButton.RecomImage.isHidden = false
                selButton.dayLable.textColor = YCColorBlack
                selButton.dismoneyLable.textColor = YCColorBlack
                selButton.moneyLable.textColor = YCColorBlack
                selButton.oldmoneyLable.textColor = YCColorBlack
            }
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(action:)))
            tapGesture.numberOfTapsRequired = 1
            selButton.addGestureRecognizer(tapGesture)
        }
        /**  恢复购买 */
        let lastButton =  self.viewWithTag(12) as? LYBuyButton
        let recoveryBuy = UILabel()
        recoveryBuy.text = "恢复购买"
        recoveryBuy.font = YC_FONT_PFSC_Medium(17)
        recoveryBuy.textAlignment = NSTextAlignment.center
        recoveryBuy.textColor = YCColorWhite
        recoveryBuy.isUserInteractionEnabled = true
        recoveryBuy.alpha = 0.3
        mainScrollView.addSubview(recoveryBuy)
        recoveryBuy.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(lastButton!.snp.bottom).offset(43)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(recoverGestureAction))
        tapGesture.numberOfTapsRequired = 1
        recoveryBuy.addGestureRecognizer(tapGesture)
        /** 分割线 */
        let line = UIView()
        line.backgroundColor = YCColorWhite
        line.alpha = 0.3
        mainScrollView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.width.equalTo(Main_Screen_Width-60)
            make.top.equalTo(recoveryBuy.snp.bottom).offset(20)
            make.height.equalTo(1)
        }
        /**  订阅信息 */
        let infoLable = UILabel()
        infoLable.text = "订阅信息"
        infoLable.font = YC_FONT_PFSC_Medium(15)
        infoLable.textColor = YCColorWhite
        infoLable.isUserInteractionEnabled = true
        infoLable.alpha = 0.3
        mainScrollView.addSubview(infoLable)
        infoLable.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(line.snp.bottom).offset(18)
        }
        /**  订阅描述 */
        let infoContentLable = UILabel()
        infoContentLable.text = "SpeedTest 升级到高级版\n\n- 订阅时长:1个月，6个月，或12个月\n- 价格和单位:CN￥6.00/月,CN￥24.00/6个月,或CN￥30.00/12个月\n\n- 可以在iTunes和App Store Apple ID设置中随时取消订阅。所有价格均包含适用的当地销售税。\n- 付款将在确认购买时从iTunes账户中扣除。\n- 订阅会自动续订，除非在当前期间结束前至少24小时关闭自动续订。\n- 账户将在当前期间结束前24小时内收取续订费用，并确定续订费用。\n- 订阅可由用户管理，并且可以通过转到以下方式关闭自动续订购买后用户的账户设置。\n- 在有效订阅期间不允许取消当前订阅。"
        infoContentLable.font = YC_FONT_PFSC_Medium(13)
        infoContentLable.textColor = YCColorWhite
        infoContentLable.numberOfLines = 0
        infoContentLable.isUserInteractionEnabled = true
        infoContentLable.alpha = 0.3
        mainScrollView.addSubview(infoContentLable)
        infoContentLable.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.width.equalTo(Main_Screen_Width-60)
            make.top.equalTo(infoLable.snp.bottom).offset(15)
        }
        /** 购买协议 */
        let buyDislable = WPHotspotLabel()
        buyDislable.font = YC_FONT_PFSC_Medium(13)
        buyDislable.numberOfLines = 0
        buyDislable.textColor = YCColorMainGray
        buyDislable.textAlignment = NSTextAlignment.left
        mainScrollView.addSubview(buyDislable)
        buyDislable.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.width.equalTo(Main_Screen_Width-60)
            make.top.equalTo(infoContentLable.snp.bottom).offset(0)
        }
    let recoverStyle = ["pro1":WPAttributedStyleAction.styledAction(action: {
        print("=====选择协议")
        self.selYsXyMemBlock!()
    }),"pro2":WPAttributedStyleAction.styledAction(action: {
        print("=====选择条款")
        self.selServerMemBlock!()
    }),"u":[YCColorMainGray, [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]],"link":YCColorWhite] as [String : Any]
    buyDislable.attributedText = "- <pro1><u>隐私协议</u></pro1> 和 <pro2><u>服务条款</u></pro2> </pro> ".attributedString(withStyleBook: recoverStyle)
    }
    
    @objc fileprivate func tapGestureAction(action:UITapGestureRecognizer){
        selBuyMemBlock!((action.view?.tag)!)
    }
    @objc fileprivate func recoverGestureAction(action:UITapGestureRecognizer){
        recoverBuyMemBlock!()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
