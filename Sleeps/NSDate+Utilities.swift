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
    class func bhat_dateWithYear(year: Int, month: Int, day: Int) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        return calendar!.dateFromComponents(dateComponents)!
    }
    
    
    /// Return a new NSDate set to midnight on the day of the given date.
    class func midnightOnDate(date: NSDate) -> NSDate {
        let interval = date.timeIntervalSinceReferenceDate
        let midnightInterval = interval - (interval % 86400)
        return NSDate(timeIntervalSinceReferenceDate: midnightInterval)
    }
    
    
    /// Convert the date to a string with the given time style and date style. These default to
    /// `.NoStyle` and `.LongStyle` respectively.
    func localisedString(timeStyle: NSDateFormatterStyle = .NoStyle, dateStyle: NSDateFormatterStyle = .LongStyle) -> String {
        let formatter = NSDateFormatter()
        formatter.timeStyle = timeStyle
        formatter.dateStyle = dateStyle
        
        return formatter.stringFromDate(self)
    }
    
    
    /// Get the start of day of tomorrow (i.e. midnight tonight, in most cases).
    class func startOfDayTomorrow() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        
        // Create a date component which adds one day.
        let oneDayComponent = NSDateComponents()
        oneDayComponent.day = 1
        
        // Get tomorrow's date by finding the start of today and adding a day.
        let startOfToday = calendar.startOfDayForDate(NSDate())
        let tomorrow = calendar.dateByAddingComponents(oneDayComponent, toDate: startOfToday, options: NSCalendarOptions())
        
        // If there was a daylight savings time transition today or tomorrow, the start of tomorrow
        // may be incorrect, so get the start of tomorrow using the date we just found.
        return calendar.startOfDayForDate(tomorrow!)
    }
    
}
