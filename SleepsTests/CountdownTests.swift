//
//  CountdownTests.swift
//  Sleeps
//
//  Created by Josh Asch on 13/06/2015.
//  Copyright © 2015 Bearhat. All rights reserved.
//

import XCTest
import CoreData

@testable
import Sleeps

class CountdownTests: XCTestCase {
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        
        // Create an in-memory Core Data stack which can be used to test interaction with the
        // database, without having to actually store anything on disk.
        if let model = NSManagedObjectModel.mergedModelFromBundles([NSBundle.mainBundle()])
        {
            let storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
            do
            {
                try storeCoordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
                managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
                managedObjectContext.persistentStoreCoordinator = storeCoordinator
            }
            catch
            {
                XCTFail("Failed to initialise a mock Core Data stack")
            }
        }
        else
        {
            XCTFail("Failed to initialise an object model")
        }
    }
    
    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    /// Check that the daysFromNow() function returns the expected value.
    func testThatDaysFromNowWorks()
    {
        let countdown = Countdown.createObjectInContext(managedObjectContext)
        
        // Set the date to be a week from now and check that daysFromNow() returns 7.
        countdown.date = NSDate(timeIntervalSinceNow: 7 * 86400)
        XCTAssertEqual(countdown.daysFromNow(), 7)
    }
    
    
    /// Check that daysFromNow() returns the expected zero if the countdown's date is today.
    func testThatDaysFromNowReturnsZeroForToday()
    {
        let countdown = Countdown.createObjectInContext(managedObjectContext)
        
        // Set the date to be in one second. If that puts the date over the boundary, keep trying
        // until both dates occur on the same day.
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let units: NSCalendarUnit = [.Day]
        
        var nowComponents: NSDateComponents
        var dateComponents: NSDateComponents
        var date: NSDate
        
        repeat
        {
            let now = NSDate()
            nowComponents = calendar!.components(units, fromDate: now)
            date = NSDate(timeIntervalSinceNow: 1)
            dateComponents = calendar!.components(units, fromDate: date)
        }
        while dateComponents.day != nowComponents.day
        
        countdown.date = date
        XCTAssertEqual(countdown.daysFromNow(), 0)
    }
    
    
    /// Check that daysFromNow() returns the expected zero if the countdown's date is today and the
    /// time component is in the past.
    func testThatDaysFromNowReturnsZeroForTodayInPast()
    {
        let countdown = Countdown.createObjectInContext(managedObjectContext)
        
        // Set the date to be one second ago. If that puts the date over the boundary, keep trying
        // until both dates occur on the same day.
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let units: NSCalendarUnit = [.Day]
        
        var nowComponents: NSDateComponents
        var dateComponents: NSDateComponents
        var date: NSDate
        
        repeat
        {
            let now = NSDate()
            nowComponents = calendar!.components(units, fromDate: now)
            date = NSDate(timeIntervalSinceNow: -1)
            dateComponents = calendar!.components(units, fromDate: date)
        }
            while dateComponents.day != nowComponents.day
        
        countdown.date = date
        XCTAssertEqual(countdown.daysFromNow(), 0)
    }
    
}