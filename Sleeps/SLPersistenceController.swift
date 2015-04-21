//
//  SLPersistenceController.swift
//  Sleeps
//
//  Created by Josh Asch on 17/04/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import Foundation
import CoreData

public class SLPersistenceController {
    
    /// This is the public object context, and is the "source of truth".
    public var managedObjectContext: NSManagedObjectContext?
    
    /// This private context has a single job, which is writing to disk.
    private var privateObjectContext: NSManagedObjectContext?
    
    /// This callback will be called when the Core Data store is initialised.
    private var callback: (Bool) -> Void
    
    /// Initialise the controller and call the given callback when complete. This initialiser
    /// will return immediately (hence the callback parameter). The parameter to the callback
    /// function is a `Bool` which represents whether the Core Data store was successfully created.
    init(callback: (Bool) -> Void)
    {
        self.callback = callback
        initialiseCoreData()
    }
    
    /// If there are any changes to save, do so. The main context will be saved first, since it's
    /// the "source of truth", and then the private context will be saved in order to write the
    /// changes to disk.
    public func save()
    {
        // Check that we actuall have object contexts to save to.
        if let privateContext = privateObjectContext, let publicContext = managedObjectContext
        {
            // If neither object context has changes, do nothing to avoid wasting time.
            if !privateContext.hasChanges && !publicContext.hasChanges
            {
                return
            }
            
            // We cannot guarantee that we are on the main thread, so use performBlockAndWait() to
            // do the save.
            publicContext.performBlockAndWait
            {
                var error: NSErrorPointer = nil
                publicContext.save(error)
                
                if let err = error.memory
                {
                    println("Failed to save to main context: \(err.localizedDescription)")
                    println("\(err.userInfo)")
                }
                else
                {
                    // The call to the private context is fine to be asynchronous.
                    privateContext.performBlock
                    {
                        privateContext.save(error)
                        
                        if let err = error.memory
                        {
                            println("Failed to save to private context: \(err.localizedDescription)")
                            println("\(err.userInfo)")
                        }
                    }
                }
            }
        }
    }
    
    /// Perform initialisation of the two object contexts. If this function has already been called,
    /// it will return without doing anything, rather than overwriting the existing contexts.
    private func initialiseCoreData()
    {
        // If we already have a managed object context, stop before we overwrite the old instance.
        if let context = self.managedObjectContext
        {
            return
        }
        
        // Create the object model.
        let modelURL = NSBundle.mainBundle().URLForResource("Sleeps", withExtension: "momd")
        let objectModel = NSManagedObjectModel(contentsOfURL: modelURL!)
        
        // If we successfully created the object model, create the managed object contexts.
        if let objectModel = objectModel
        {
            // Create a persistent store coordinator to use for the private object context.
            let coordinator = NSPersistentStoreCoordinator(managedObjectModel: objectModel)
            
            // Create the main object context.
            managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
            
            // Create the private context and set its store coordinator to be the one we just
            // created.
            privateObjectContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
            privateObjectContext?.persistentStoreCoordinator = coordinator
            
            // Set the main object context to be a child context of the private one.
            managedObjectContext?.parentContext = privateObjectContext
            
            // Asynchronously create a reference to the datastore on disk.
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0))
            {
                let storeCoordinator = self.privateObjectContext?.persistentStoreCoordinator
                
                // Set the options for the store.
                var options = [String: AnyObject]()
                options[NSMigratePersistentStoresAutomaticallyOption] = true
                options[NSInferMappingModelAutomaticallyOption] = true
                options[NSSQLitePragmasOption] = ["journal_mode": "DELETE"]
                
                // Get the URL to the store on disk. We use the Documents directory, and a filename
                // of "DataModel.sqlite".
                let fileManager = NSFileManager.defaultManager()
                let documentsURL: NSURL? = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last as? NSURL
                let storeURL = documentsURL?.URLByAppendingPathComponent("DataModel.sqlite")
                
                // Actually create the store.
                var error: NSErrorPointer = nil
                let store = storeCoordinator?.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: options, error: error)
                
                // If something went wrong, log it to the console.
                if let err = error.memory
                {
                    println("Error initialising persistent store coordinator: \(err.localizedDescription)")
                    println("\(err.userInfo)")
                }
                
                // Call the callback which we were provided with, passing in a Bool to show whether
                // the operation was successful.
                dispatch_sync(dispatch_get_main_queue()) {
                    self.callback(error == nil)
                }
            }
        }
        else
        {
            println("Could not initialise Core Data; no data model was found")
            
            // Call the callback which we were provided with, passing in false to show that an
            // error occurred.
            dispatch_sync(dispatch_get_main_queue()) {
                self.callback(false)
            }
        }
    }
}