//
//  SleepsTests.swift
//  SleepsTests
//
//  Created by Josh Asch on 30/03/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit
import XCTest
import CoreData

class SleepsTests: XCTestCase {
    
    var managedObjectModel: NSManagedObjectContext!
    
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
                managedObjectModel = NSManagedObjectContext()
                managedObjectModel.persistentStoreCoordinator = storeCoordinator
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
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
