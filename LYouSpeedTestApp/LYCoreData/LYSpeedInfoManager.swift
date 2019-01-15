//
//  LYSpeedInfoManager.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/8.
//  Copyright © 2019 grx. All rights reserved.
//

import UIKit

private let LYSpeedInfoShareInstance = LYSpeedInfoManager()

class LYSpeedInfoManager: NSObject {
    class var shared : LYSpeedInfoManager {
        return LYSpeedInfoShareInstance
    }
    /** 添加数据到本地数据库 */
    func addSpeedInfo(toLocalData model: LYHomeModel?) {
        let info = LYSpeedInfo.mr_createEntity()
        info?.delayeSpeed = model?.delay
        info?.downSpeed = model?.downSpeed
        info?.upSpeed = model?.upSpeed
        info?.isWifi = model?.isWifi
        info?.currenTime = model?.currenTime
        info?.currenDate = model?.currenDate
        info?.currenWifiName = model?.currenWifiName
        info?.downOringSpeed = (model?.downOringSpeed)!
        info?.upOringSpeed = (model?.upOringSpeed)!

        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
    }
    /** 查询本地所有数据 */
    func searchAllLocalListData() -> [Any]? {
        let listData = LYSpeedInfo.mr_findAll()
        return listData
    }
    /** 删除本地所有数据 */
    func cancleAllLocalData() {
        LYSpeedInfo.mr_truncateAll()
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
    }
}
