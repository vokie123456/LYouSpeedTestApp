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
        self.backgroundColor = YCColorWhite
        creatUI()
    }
    
    func creatUI() {
        self.addSubview(iocnImageView)
        iocnImageView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(15)
            make.width.equalTo(17)
            make.height.equalTo(16)
        }
        self.addSubview(titleLable)
        titleLable.textAlignment = NSTextAlignment.left
        titleLable.font = YC_FONT_PFSC_Medium(13)
        titleLable.textColor = YCColorBlack
        titleLable.alpha = 0.8
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(iocnImageView.snp.right).offset(25)
            make.top.equalTo(0)
            make.right.equalTo(-20)
            make.height.equalTo(48)
        }
        let line = UIView()
        self.addSubview(line)
        line.backgroundColor = YCColorGray
        line.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(43)
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
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.width.equalTo(170)
            make.height.equalTo(45)
        }
        let tilArr = ["Mbps","KB/s"]
        for i in 0..<2 {
            let selButton = UIButton()
            swichView.addSubview(selButton)
            selButton.layer.cornerRadius = 25/2
            selButton.layer.borderWidth = 1
            selButton.tag = i+10
            selButton.setTitle(tilArr[i], for: .normal)
            selButton.titleLabel?.font = YC_FONT_PFSC_Medium(11)
            selButton.layer.borderColor = YCColorDarkLight.cgColor
            selButton.setTitleColor(YCColorDarkLight, for: .normal)
            selButton.snp.makeConstraints { (make) in
                make.left.equalTo(35+i*65)
                make.top.equalTo(10)
                make.width.equalTo(50)
                make.height.equalTo(25)
            }
            if(selButton.tag==10){
                selButton.layer.borderColor = YCColorStanBlue.cgColor
                selButton.setTitleColor(YCColorStanBlue, for: .normal)
                selButton.backgroundColor = YCColorWhite
            }
            selButton.addTarget(self, action: #selector(selButtonClick(_:)), for:.touchUpInside)
        }
    }
    
    @objc func selButtonClick(_ button:UIButton){
        for i in 0..<2 {
            let btn:UIButton = self.viewWithTag(i+10) as! UIButton
            btn.layer.borderColor = YCColorDarkLight.cgColor
            btn.setTitleColor(YCColorDarkLight, for: .normal)
            btn.backgroundColor = UIColor.clear
        }
        button.setTitleColor(YCColorStanBlue, for: .normal)
        button.layer.borderColor = YCColorStanBlue.cgColor
        button.backgroundColor = YCColorWhite
        callSelBlock!(button.tag)
    }
    
    func gaintTag(tag:NSInteger) {
        switch tag {
        case 0:
            arrow.isHidden = true
            swichView.isHidden = false
            break
        case 20:
            iocnImageView.snp.updateConstraints { (make) in
                make.top.equalTo(16)
            }
            break
        case 21:
            iocnImageView.snp.updateConstraints { (make) in
                make.top.equalTo(17)
            }
            break
        case 30:
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
