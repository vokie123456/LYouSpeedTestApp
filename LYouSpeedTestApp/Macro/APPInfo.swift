//
//  APPInfo.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/7.
//  Copyright © 2019 grx. All rights reserved.
//

import Foundation

/** 获取ip列表 */
let LYIosSwitch = "http://bz.pk2game.com/LYouSpeedIosSwitch"
/** 获取ip列表 */
let LYIPListURL = "http://bz.pk2game.com/ipList"
/** 上下行测试地址 */
let LYTestPointURL = "http://bz.pk2game.com/testPoint"
/** 校验苹果支付成功凭证 */
let LYIosCheck = "http://bz.pk2game.com/LYouSpeedIosCheck"

//IP地址
func IPADRESS() -> String {
    let ipAdress = UserDefaults.standard.string(forKey: "ipAdress")
    //判断UserDefaults中是否已经存在
    if ipAdress != nil {
        return ipAdress!
    }else{
        return ""
    }
}

//下载地址
func DownLoadUrl() -> String {
    let downLoadUrl = UserDefaults.standard.string(forKey: "downLoadUrl")
    //判断UserDefaults中是否已经存在
    if downLoadUrl != nil {
        return downLoadUrl!
    }else{
        return ""
    }
}

//上传地址
func UpLoadUrl() -> String {
    let upLoadUrl = UserDefaults.standard.string(forKey: "upLoadUrl")
    //判断UserDefaults中是否已经存在
    if upLoadUrl != nil {
        return upLoadUrl!
    }else{
        return ""
    }
}
//审核状态
func ISCHECKIOS() -> String {
    let isCheckIos = UserDefaults.standard.string(forKey: "isCheckIos")
    //判断UserDefaults中是否已经存在
    if isCheckIos != nil {
        return isCheckIos!
    }else{
        return ""
    }
}
//是否购买会员
func ISHAVEBUYMEMBER() -> String {
    let isHaveBuyMemBer = UserDefaults.standard.string(forKey: "isHaveBuyMemBer")
    //判断UserDefaults中是否已经存在
    if isHaveBuyMemBer != nil {
        return isHaveBuyMemBer!
    }else{
        return ""
    }
}
