//
//  SLCountdown.swift
//  Sleeps
//
//  Created by Josh Asch on 30/03/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import Foundation
import CoreData

class SLCountdown: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var date: NSDate
    @NSManaged var index: NSNumber
    @NSManaged var colour: NSNumber
    @NSManaged var icon: NSNumber

}
