//
//  Countdown.swift
//  Sleeps
//
//  Created by Josh Asch on 12/05/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import Foundation
import CoreData

class Countdown: NSManagedObject {

    @NSManaged var colour: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var icon: NSNumber
    @NSManaged var repeatInterval: NSNumber
    @NSManaged var name: String

}
