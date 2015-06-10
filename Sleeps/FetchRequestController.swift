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
            do
            {
                let results = try context.executeFetchRequest(fetchRequest) as? [T]
                return results
            }
            catch let error as NSError
            {
                print("Error fetching objects: - \(error.localizedDescription)")
                print("\(error.userInfo)")
                
                return nil
            }
        }
        else
        {
            return nil
        }
    }
}
