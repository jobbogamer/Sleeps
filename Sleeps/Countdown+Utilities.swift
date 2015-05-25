//
//  Countdown+CoreData.swift
//  Sleeps
//
//  Created by Josh Asch on 04/05/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit
import CoreData


enum RepeatInterval: Int16
{
    case Never
    case Weekly
    case Monthly
    case Yearly
}


extension Countdown: Entity {
    
    // MARK: - Class functions
    
    /// Get the entity name as used in the Core Data model. Required for the `Entity` protocol.
    static var entityName: String {
        get { return "Countdown" }
    }
    
    
    
    /// Create a new `Countdown` object in the given `NSManagedObjectContext`.
    class func createObjectInContext(context: NSManagedObjectContext) -> Countdown
    {
        return NSEntityDescription.insertNewObjectForEntityForName(self.entityName, inManagedObjectContext: context) as! Countdown
    }
    
    
    
    /// Return the `UIColor` object represented by the countdown's `colour` property.
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
    
    
    /// Create and save the default countdowns added on first launch.
    class func createDefaultCountdownsUsingPersistenceController(persistenceController: PersistenceController)
    {
        // Get the current date to work out what year to set for each countdown.
        let now = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let units: NSCalendarUnit = (.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay)
        let dateComponents = calendar!.components(units, fromDate: now)

        let thisYear = dateComponents.year
        let nextYear = dateComponents.year + 1
        
        // Calculate the years for each countdown.
        let piYear: Int
        let starWarsYear: Int
        let pirateYear: Int
        
        if dateComponents.month > 9 || (dateComponents.month == 9 && dateComponents.day >= 19)
        {
            piYear = nextYear
            starWarsYear = nextYear
            pirateYear = nextYear
        }
        else if dateComponents.month > 5 || (dateComponents.month == 5 && dateComponents.day >= 4)
        {
            piYear = nextYear
            starWarsYear = nextYear
            pirateYear = thisYear
        }
        else if dateComponents.month > 3 || (dateComponents.month == 3 && dateComponents.day >= 14)
        {
            piYear = nextYear
            starWarsYear = thisYear
            pirateYear = thisYear
        }
        else
        {
            piYear = thisYear
            starWarsYear = thisYear
            pirateYear = thisYear
            
        }
        
        // First default countdown: Pi Day (14/3).
        var piDay = createObjectInContext(persistenceController.managedObjectContext!)
        piDay.name = "Pi Day"
        piDay.colour = Int(arc4random_uniform(9))
        // TODO: Set the icon.
        piDay.setRepeatInterval(.Yearly)
        piDay.date = NSDate.bhat_dateWithYear(piYear, month: 3, day: 14)
        
        // Second default countdown: Star Wars Day (4/5).
        var starWarsDay = createObjectInContext(persistenceController.managedObjectContext!)
        starWarsDay.name = "Star Wars Day"
        starWarsDay.colour = Int(arc4random_uniform(9))
        // TODO: Set the icon.
        starWarsDay.setRepeatInterval(.Yearly)
        starWarsDay.date = NSDate.bhat_dateWithYear(starWarsYear, month: 5, day: 4)
    
        // Third default countdown: Talk Like A Pirate Day (19/9)
        var pirateDay = createObjectInContext(persistenceController.managedObjectContext!)
        pirateDay.name = "Talk Like A Pirate Day"
        pirateDay.colour = Int(arc4random_uniform(9))
        // TODO: Set the icon.
        pirateDay.setRepeatInterval(.Yearly)
        pirateDay.date = NSDate.bhat_dateWithYear(pirateYear, month: 9, day: 19)
        
        // Save the new countdowns into the database.
        persistenceController.save()
    }
    
    
    class func isBefore(lhs: Countdown, rhs: Countdown) -> Bool
    {
        return lhs.date.compare(rhs.date) == .OrderedAscending
    }
    
    
    // MARK: - Instance methods
    
    
    /// Get the number of days between the countdown's `date` and now.
    func daysFromNow() -> Int
    {
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.components(.CalendarUnitDay, fromDate: NSDate(), toDate: date, options: nil)
        return dateComponents.day
    }
    
    
    /// Get the countdown's colour as a `UIColor` object.
    func getColour() -> UIColor
    {
        return Countdown.colourFromIndex(self.colour.integerValue)
    }
    
    
    /// Get the countdown's repeat interval as an enum value rather than a raw Int16.
    func getRepeatInterval() -> RepeatInterval
    {
        return RepeatInterval(rawValue: self.repeatInterval.shortValue)!
    }
    
    
    /// Set the countdown's repeat interval using an enum value rather than a raw Int16.
    func setRepeatInterval(interval: RepeatInterval)
    {
        self.repeatInterval = NSNumber(short: interval.rawValue)
    }
    
    
    func repeatIntervalString() -> String
    {
        switch (self.getRepeatInterval())
        {
        case .Yearly:
            return "Repeats Yearly"
            
        case .Monthly:
            return "Repeats Monthly"
            
        case .Weekly:
            return "Repeats Weekly"
            
        case .Never:
            return "Never Repeats"
        }
    }
    
}