//
//  LYSpeedInfo+CoreDataProperties.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/15.
//  Copyright © 2019 grx. All rights reserved.
//
//

import Foundation
import CoreData


extension LYSpeedInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LYSpeedInfo> {
        return NSFetchRequest<LYSpeedInfo>(entityName: "LYSpeedInfo")
    }

    @NSManaged public var currenDate: String?
    @NSManaged public var currenTime: String?
    @NSManaged public var currenWifiName: String?
    @NSManaged public var delayeSpeed: String?
    @NSManaged public var downSpeed: String?
    @NSManaged public var isWifi: String?
    @NSManaged public var upSpeed: String?
    @NSManaged public var downOringSpeed: Float
    @NSManaged public var upOringSpeed: Float

}
