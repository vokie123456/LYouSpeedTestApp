//
//  LYSettingCell.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/28.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit

class LYSettingCell: UITableViewCell {
    let iocnImageView = UIImageView()
    let titleLable = UILabel()
    let arrow = UIImageView()
    let swichView = UIView()
    var callSelBlock:((_ buttonTag:Int)->Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = YCColorMain
        creatUI()
    }
    
    func creatUI() {
        self.addSubview(iocnImageView)
        iocnImageView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(10)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        self.addSubview(titleLable)
        titleLable.textAlignment = NSTextAlignment.left
        titleLable.font = YC_FONT_PFSC_Medium(15)
        titleLable.textColor = YCColorWhite
        titleLable.alpha = 0.8
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(iocnImageView.snp.right).offset(25)
            make.top.equalTo(0)
            make.right.equalTo(-20)
            make.height.equalTo(48)
        }
        let line = UIView()
        self.addSubview(line)
        line.backgroundColor = YCColorWhite
        line.alpha = 0.1
        line.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(50)
            make.right.equalTo(-20)
            make.height.equalTo(1)
        }
        arrow.image = UIImage(named:"backToRight")
        self.addSubview(arrow)
        arrow.alpha = 0.8
        arrow.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(17)
            make.width.equalTo(10)
            make.height.equalTo(14)
        }
        /** 选择速度单位开关 */
        self.addSubview(swichView)
        swichView.isHidden = true
        swichView.backgroundColor = UIColor(white: 1, alpha: 0)
        swichView.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(0)
            make.width.equalTo(180)
            make.height.equalTo(55)
        }
        let tilArr = ["Mbps","KB/s"]
        for i in 0..<2 {
            let selButton = UIButton()
            swichView.addSubview(selButton)
            selButton.layer.cornerRadius = 35/2
            selButton.layer.borderWidth = 1
            selButton.tag = i+10
            selButton.setTitle(tilArr[i], for: .normal)
            selButton.titleLabel?.font = YC_FONT_PFSC_Medium(14)
            selButton.layer.borderColor = YCColorWhite.cgColor
            selButton.snp.makeConstraints { (make) in
                make.left.equalTo(35+i*80)
                make.top.equalTo(5)
                make.width.equalTo(68)
                make.height.equalTo(35)
            }
            if(selButton.tag==10){
                selButton.setTitleColor(YCColorBlack, for: .normal)
                selButton.backgroundColor = YCColorWhite
                selButton.alpha = 0.8
            }
            selButton.addTarget(self, action: #selector(selButtonClick(_:)), for:.touchUpInside)
        }
    }
    
    @objc func selButtonClick(_ button:UIButton){
        for i in 0..<2 {
            let btn:UIButton = self.viewWithTag(i+10) as! UIButton
            btn.setTitleColor(YCColorWhite, for: .normal)
            btn.backgroundColor = UIColor.clear
            btn.alpha = 1
        }
        button.setTitleColor(YCColorBlack, for: .normal)
        button.backgroundColor = YCColorWhite
        button.alpha = 0.8
        callSelBlock!(button.tag)
    }
    
    func gaintTag(tag:NSInteger) {
        switch tag {
        case 0:
            arrow.isHidden = true
            swichView.isHidden = false
            break
        case 3:
            iocnImageView.snp.updateConstraints { (make) in
                make.top.equalTo(11)
                make.width.equalTo(23)
                make.height.equalTo(23)
            }
            break
        case 4:
            iocnImageView.snp.updateConstraints { (make) in
                make.top.equalTo(17)
                make.width.equalTo(23)
                make.height.equalTo(15)
            }
            break
        case 5:
            titleLable.snp.updateConstraints { (make) in
                make.top.equalTo(-2)
            }
            break
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
