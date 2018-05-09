//
//  Activity+CoreDataProperties.swift
//  RunningStairs
//
//  Created by Vlad on 09/05/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var duration: Int64
    @NSManaged public var endDate: NSDate?
    @NSManaged public var floors: Int64
    @NSManaged public var pace: Double
    @NSManaged public var startDate: NSDate?

}
