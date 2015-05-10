//
//  FetchRequestController.swift
//  Sleeps
//
//  Created by Josh Asch on 10/05/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import CoreData

class FetchRequestController {
    
    class func getAllObjectsOfType<T where T: Entity, T: NSManagedObject>(type: T.Type, fromPersistenceController persistenceController: PersistenceController) -> [T]?
    {
        if let context = persistenceController.managedObjectContext
        {
            // Create a fetch request asking for all the countdowns.
            let fetchRequest = NSFetchRequest(entityName: type.entityName)
            
            // Execute the fetch request.
            var error: NSError? = nil
            var results = context.executeFetchRequest(fetchRequest, error: &error) as! [T]?
            
            // Check whether anything went wrong.
            if let error = error
            {
                println("Error fetching objects: - \(error.localizedDescription)")
                println("\(error.userInfo)")
                
                return nil
            }
            else
            {
                // Nothing went wrong so return the results.
                return results
            }
        }
        else
        {
            return nil
        }
    }
}
