//
//  CountdownTableViewController.swift
//  Sleeps
//
//  Created by Josh Asch on 30/03/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit
import CoreData

class CountdownCollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    /// Persistence controller passed in from the AppDelegate at launch.
    var persistenceController: PersistenceController?
    
    /// Array of Countdown objects from the database, used as the data for the collection view.
    var countdowns: [Countdown] = [Countdown]() {
        
        didSet {
            // Whenever our array of countdowns changes, reload the collection view data.
            collectionView?.reloadData()
        }
        
    }
    
    
    
    /// Get all the countdowns from the persistence controller and store them in the countdowns
    /// array. This function only does anything if the persistence controller exists.
    func reloadData()
    {
        if let context = persistenceController?.managedObjectContext
        {
            // Create a fetch request asking for all the countdowns.
            let fetchRequest = NSFetchRequest(entityName: Countdown.entityName())
            
            // Execute the fetch request.
            var error: NSError? = nil
            if let results = context.executeFetchRequest(fetchRequest, error: &error) as? [Countdown]
            {
                // The request was successful, copy the results into our array.
                countdowns = results
                
                println("Found \(countdowns.count) countdowns")
            }
            else
            {
                // Something went wrong.
                if let error = error
                {
                    println("Error fetching countdowns: - \(error.localizedDescription)")
                    println("\(error.userInfo)")
                }
                else
                {
                    println("Unknown error when fetching countdowns")
                }
            }

        }
    }
    
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad()
    {
        
    }
    
    
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        // TODO: Return the number of items fetched from the database.
        return 0
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // Always return 1, because there are no logical groups or sections in the data.
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        // TODO: Dequeue a cell, fill it with goodness.
        return UICollectionViewCell()
    }
    
    
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        // TODO: Perform a segue to the single-item view or editing view.
    }
    
}
