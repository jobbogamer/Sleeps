//
//  NSDate+Utilities.swift
//  Sleeps
//
//  Created by Josh Asch on 12/05/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit

extension NSDate {
    
    /// Create a new NSDate object set to the given date.
    class func bhat_dateWithYear(year: Int, month: Int, day: Int) -> NSDate
    {
        let dateComponents = NSDateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        return calendar!.dateFromComponents(dateComponents)!
    }
    
    
    /// Convert the date to a string with the given time style and date style. These default to
    /// `.NoStyle` and `.LongStyle` respectively.
    func localisedString(timeStyle: NSDateFormatterStyle = .NoStyle, dateStyle: NSDateFormatterStyle = .LongStyle) -> String
    {
        let formatter = NSDateFormatter()
        formatter.timeStyle = timeStyle
        formatter.dateStyle = dateStyle
        
        return formatter.stringFromDate(self)
    }
    
}
