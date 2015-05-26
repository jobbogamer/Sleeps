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
        // Use FetchRequestController to get all the countdowns from the database. If no error
        // occurs, set `self.countdowns` to the returned results, which will trigger the collection
        // view to refresh itself.
        if let persistenceController = persistenceController
        {
            if let fetchedCountdowns = FetchRequestController.getAllObjectsOfType(Countdown.self, fromPersistenceController: persistenceController)
            {
                var sortedCountdowns = fetchedCountdowns
                sortedCountdowns.sort(Countdown.isBefore)
                self.countdowns = sortedCountdowns
            }
        }
    }
    
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // The size of one countdown cell should be a square with side length equal to half the
        // available width of the screen.
        let screenSize = UIScreen.mainScreen().bounds
        let availableSpace = screenSize.width - (kCollectionViewOuterMargin * 2) - kCollectionViewItemSpacing
        let itemLength: CGFloat
        
        // If the available space is an odd number, subtract one to avoid half-pixel values.
        if availableSpace % 2 == 1
        {
            itemLength = (availableSpace - 1) / 2
        }
        else
        {
            itemLength = availableSpace / 2
        }
        
        // Create a UICollectionViewFlowLayout to use as the collection view layout.
        let flowLayout = UICollectionViewFlowLayout()
        
        // Set the flow layout properties.
        flowLayout.scrollDirection         = .Vertical
        flowLayout.itemSize                = CGSizeMake(itemLength, itemLength)
        flowLayout.minimumInteritemSpacing = kCollectionViewItemSpacing
        flowLayout.minimumLineSpacing      = kCollectionViewItemSpacing
        flowLayout.sectionInset            = UIEdgeInsets.InsetsWithEqualSize(kCollectionViewOuterMargin)
        
        // Add the flow layout to the collection view.
        collectionView?.setCollectionViewLayout(flowLayout, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Whenever the view is about to appear on screen, reload the countdowns into the view.
        reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Choose what to do based on the segue being performed.
        if segue.identifier! == kNewCountdownSegueIdentifier
        {
            // The New button was tapped.
        }
        else
        {
            // A countdown cell was tapped.
            if let sender    = sender as? UICollectionViewCell,
                   indexPath = collectionView?.indexPathForCell(sender)
            {
                let countdown = countdowns[indexPath.row]
                
                // Pass the countdown to the destination view controller.
                let editViewController = segue.destinationViewController as? EditViewController
                editViewController?.countdown = countdown
            }
        }
    }
    
    
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        // Return the number of items fetched from the database.
        return countdowns.count + 1
    }
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // Always return 1, because there are no logical groups or sections in the data.
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        if indexPath.row == countdowns.count
        {
            // Get a ButtonsCell.
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kButtonsCellIdentifier, forIndexPath: indexPath) as! ButtonsCell
            
            // Tell the cell to set up its visual properties.
            cell.setUp()
            
            return cell
        }
        else
        {
            // Get a CountdownCell.
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCountdownCellIdentifier, forIndexPath: indexPath) as! CountdownCell
            
            // Give the cell the countdown from the array at the correct index.
            cell.countdown = countdowns[indexPath.row]
            
            // Tell the cell to set up its visual properties.
            cell.setUp()
            
            return cell
        }
    }
    
}
