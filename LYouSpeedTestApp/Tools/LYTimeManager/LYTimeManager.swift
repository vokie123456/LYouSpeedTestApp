//
//  LYTimeManager.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/8.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

private let timeShareInstance = LYTimeManager()

class LYTimeManager: NSObject {
    class var shared : LYTimeManager {
        return timeShareInstance
    }
    /** 获取当前时间 */
    func gaintCurrenTime() -> String {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.hour,.minute,.second], from: Date())
        let hour = com.hour!
        let minute = com.minute!
        return "\(hour):\(minute)"
    }
    
    func gaintCurrenDate() -> String {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: Date())
        let month = com.month!
        let day = com.day!
        return "\(month)月\(day)日"
    }
    
}
