//
//  NSDate+Utilities.swift
//  Sleeps
//
//  Created by Josh Asch on 12/05/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit

extension NSDate {
    
    class func bhat_dateWithYear(year: Int, month: Int, day: Int) -> NSDate
    {
        let dateComponents = NSDateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        return calendar!.dateFromComponents(dateComponents)!
    }
    
}
