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
    
    
    /// Get the number of days between the given date and now.
    func daysFromNow(date: NSDate) -> Int
    {
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.components(NSCalendarUnit.CalendarUnitDay, fromDate: NSDate(), toDate: date, options: nil)
        return dateComponents.day
    }
    
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad()
    {
    }
    
    override func viewWillAppear(animated: Bool) {
        // Whenever the view is about to appear on screen, reload the countdowns into the view.
        reloadData()
    }
    
    
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        // Return the number of items fetched from the database, plus one for use as the "Add New"
        // button at the end of the list.
        return countdowns.count + 1
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // Always return 1, because there are no logical groups or sections in the data.
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell: UICollectionViewCell
        
        if indexPath.row == countdowns.count
        {
            // We're being asked to provide the "Add New" button item.
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("NewButtonCell", forIndexPath: indexPath) as! UICollectionViewCell
            
            cell.backgroundColor = UIColor.yellowColor()

            let imageView = cell.viewWithTag(1)
            imageView?.backgroundColor = UIColor.blueColor()
            imageView?.layer.cornerRadius = 0.5
            imageView?.layer.masksToBounds = true
        }
        else
        {
            // We're being asked to provide a regular cell.
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("CountdownCell", forIndexPath: indexPath) as! UICollectionViewCell
            
            let countdown = countdowns[indexPath.row]
            
            let imageView = cell.viewWithTag(1)
            // TODO: Display the correct image in the image view.
            
            // Put the countdown's name in the view.
            let nameLabel = cell.viewWithTag(2) as! UILabel
            nameLabel.text = countdown.name
            
            // Put the number of days in the view.
            let daysLabel = cell.viewWithTag(3) as! UILabel
            let days = daysFromNow(countdown.date)
            daysLabel.text = "\(days)"
        }
        
        let screenSize = UIScreen.mainScreen().bounds
        cell.frame = CGRectMake(0, 0, screenSize.width / 2, screenSize.width / 2)
        
        let imageView = cell.viewWithTag(1)!
        imageView.backgroundColor = Countdown.colourFromIndex(-1)
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        imageView.layer.masksToBounds = true
        
        return cell
    }
    
    
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        // TODO: Perform a segue to the single-item view or editing view.
    }
    
}
