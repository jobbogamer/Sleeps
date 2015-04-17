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
    
    /// This callback will be called when the Core Data store is successfully initialised.
    private var callback: () -> Void
    
    /// Initialise the controller and call the given @param callback when complete. This initialiser
    /// will return immediately (hence the callback parameter).
    init(callback: () -> Void) {
        self.callback = callback
        self.initialiseCoreData()
    }
    
    /// If there are any changes to save, do so. The main context will be saved first, since it's
    /// the "source of truth", and then the private context will be saved in order to write the
    /// changes to disk.
    public func save() {
        
    }
    
    /// Perform initialisation of the two object contexts. If this function has already been called,
    /// it will return without doing anything, rather than overwriting the existing contexts.
    private func initialiseCoreData() {
        // If we already have a managed object context, stop before we overwrite the old instance.
        if let context = self.managedObjectContext {
            return
        }
        
        // Create the object model.
        let modelURL = NSBundle.mainBundle().URLForResource("Sleeps", withExtension: "momd")
        let objectModel = NSManagedObjectModel(contentsOfURL: modelURL!)
        
        // If we successfully created the object model, create the managed object contexts.
        if let objectModel = objectModel {
            // Create a persistent store coordinator to use for the private object context.
            let coordinator = NSPersistentStoreCoordinator(managedObjectModel: objectModel)
            
            // Create the main object context.
            self.managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
            
            // Create the private context and set its store coordinator to be the one we just
            // created.
            self.privateObjectContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
            self.privateObjectContext?.persistentStoreCoordinator = coordinator
            
            // Set the main object context to be a child context of the private one.
            self.managedObjectContext?.parentContext = privateObjectContext
            
            // TODO: Asynchronously create a reference to the datastore on disk.
        }
        else {
            println("No data model!")
        }
    }
}