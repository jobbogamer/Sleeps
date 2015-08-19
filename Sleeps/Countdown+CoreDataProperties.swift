//
//  Countdown+CoreDataProperties.swift
//  Sleeps
//
//  Created by Josh Asch on 19/08/2015.
//  Copyright © 2015 Bearhat. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension Countdown {

    @NSManaged var colour: NSNumber?
    @NSManaged var date: NSDate?
    @NSManaged var icon: NSNumber?
    @NSManaged var name: String?
    @NSManaged var repeatInterval: NSNumber?
    @NSManaged var edited: NSNumber?

}
