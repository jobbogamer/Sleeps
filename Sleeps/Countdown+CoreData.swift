//
//  Countdown+CoreData.swift
//  Sleeps
//
//  Created by Josh Asch on 04/05/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit
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
    
    class func colourFromIndex(index: Int) -> UIColor
    {
        switch (index)
        {
        case 0:
            return UIColor.blackColor()
            
        case 1:
            return UIColor.redColor()
            
        case 2:
            return UIColor.orangeColor()
            
        case 3:
            return UIColor.yellowColor()
            
        case 4:
            return UIColor.greenColor()
            
        case 5:
            return UIColor.blueColor()
            
        case 6:
            return UIColor.purpleColor()
            
        case 7:
            return UIColor.grayColor()
            
        case 8:
            return UIColor.whiteColor()
            
        default:
            return colourFromIndex(Int(arc4random_uniform(9)))
        }
    }
    
}