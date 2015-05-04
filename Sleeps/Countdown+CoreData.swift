//
//  Countdown+CoreData.swift
//  Sleeps
//
//  Created by Josh Asch on 04/05/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import Foundation
import CoreData

extension Countdown {
    
    class func entityName() -> String
    {
        return "Countdown"
    }
    
    class func createObjectInContext(context: NSManagedObjectContext) -> AnyObject
    {
        return NSEntityDescription.insertNewObjectForEntityForName(self.entityName(), inManagedObjectContext: context)
    }
    
}