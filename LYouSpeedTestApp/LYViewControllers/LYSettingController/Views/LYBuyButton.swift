//
//  LYBuyButton.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/3.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

class LYBuyButton: UIView {
    let bgView = UIImageView()
    let dayLable = UILabel()
    let dismoneyLable = UILabel()
    let moneyLable = UILabel()
    let oldmoneyLable = UILabel()
    let RecomImage = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = YCColorMain
        creatUI()
    }

    func creatUI(){
        bgView.isUserInteractionEnabled = true
        bgView.image = UIImage(named: "image_gradualColor_line_big")
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius = 15
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(0);
            make.height.equalTo(50);
        }
        /** 订阅时间 */
        dayLable.text = "1个月"
        dayLable.font = YC_FONT_PFSC_Medium(18)
        dayLable.textColor = YCColorWhite
        bgView.addSubview(dayLable)
        dayLable.snp.makeConstraints { (make) in
            make.left.equalTo(14);
            make.top.equalTo(6);
        }
        /** 订阅价格 */
        dismoneyLable.text = "CN￥6.00/月"
        dismoneyLable.alpha = 0.5
        dismoneyLable.font = YC_FONT_PFSC_Medium(12)
        dismoneyLable.textColor = YCColorWhite
        bgView.addSubview(dismoneyLable)
        dismoneyLable.snp.makeConstraints { (make) in
            make.left.equalTo(14);
            make.top.equalTo(dayLable.snp.bottom).offset(-4);
        }
        /** 订阅价格 */
        moneyLable.text = "CN￥6.00"
        moneyLable.font = YC_FONT_PFSC_Medium(18)
        moneyLable.textColor = YCColorDarkGreen
        bgView.addSubview(moneyLable)
        moneyLable.snp.makeConstraints { (make) in
            make.right.equalTo(-14);
            make.top.equalTo(6);
        }
        /** 订阅原价 */
        oldmoneyLable.text = "CN￥72.00"
        oldmoneyLable.alpha = 0.5
        oldmoneyLable.font = YC_FONT_PFSC_Medium(12)
        oldmoneyLable.textColor = YCColorWhite
        oldmoneyLable.textAlignment = NSTextAlignment.right
        bgView.addSubview(oldmoneyLable)
        oldmoneyLable.snp.makeConstraints { (make) in
            make.right.equalTo(-14);
            make.top.equalTo(moneyLable.snp.bottom).offset(-4);
            make.width.equalTo(100)
            make.height.equalTo(15)
        }
        oldmoneyLable.setNeedsDisplay()
        /** 推荐 */
        RecomImage.isUserInteractionEnabled = true
        RecomImage.image = UIImage(named: "icon_sale_cn")
        RecomImage.isHidden = true
        self.addSubview(RecomImage)
        RecomImage.snp.makeConstraints { (make) in
            make.right.equalTo(1);
            make.top.equalTo(-13);
            make.width.equalTo(28);
            make.height.equalTo(28);
        }
    }
    
    override func draw(_ rect: CGRect) {
        let length = gaintSizeWithText(text: oldmoneyLable.text! as NSString, font: oldmoneyLable.font)+3
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.gray.cgColor)
        context?.fill(CGRect(x: frame.width-length-12, y: frame.height-15, width: length, height: 0.5))
    }
    /**
     * 计算字符串长度
     */
     func gaintSizeWithText(text: NSString, font: UIFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let size = CGSize(width: 100, height: 15)
        let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect.width;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
