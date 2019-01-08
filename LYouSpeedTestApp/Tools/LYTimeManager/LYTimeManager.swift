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
        return "12:16"
    }
    
    func gaintCurrenDate() -> String {
        return "12月16日"
    }
    
}
