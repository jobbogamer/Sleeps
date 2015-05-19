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
        
        // The margin between each countdown in the view, and between the countdowns and the edge of
        // the screen.
        let itemSpacing: CGFloat = 10
        
        // The size of one countdown cell should be a square with side length equal to half the
        // available width of the screen.
        let screenSize = UIScreen.mainScreen().bounds
        let itemLength = (screenSize.width - (itemSpacing * 3)) / 2
        
        // Create a UICollectionViewFlowLayout to use as the collection view layout.
        let flowLayout = UICollectionViewFlowLayout()
        
        // Set the flow layout properties.
        flowLayout.scrollDirection         = .Vertical
        flowLayout.itemSize                = CGSizeMake(itemLength, itemLength)
        flowLayout.minimumInteritemSpacing = itemSpacing
        flowLayout.minimumLineSpacing      = itemSpacing
        flowLayout.sectionInset            = UIEdgeInsets.InsetsWithEqualSize(itemSpacing)
        flowLayout.footerReferenceSize     = CGSizeMake(0, itemLength * 0.4)
        
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
        if segue.identifier! == "NewCountdown"
        {
            // The New button was tapped.
        }
        else
        {
            // A countdown cell was tapped.
        }
    }
    
    
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        // Return the number of items fetched from the database.
        return countdowns.count
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // Always return 1, because there are no logical groups or sections in the data.
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        let view: UICollectionReusableView
        
        if kind == UICollectionElementKindSectionFooter
        {
            view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ButtonsFooter", forIndexPath: indexPath) as! UICollectionReusableView
        }
        else
        {
            // We should never be asked for a header, but we have to provide a return value.
            view = UICollectionReusableView()
        }
        
        return view
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell: UICollectionViewCell
        let backgroundColour: UIColor
        
        // TODO: Create an icon object to put into the circle.
        
        // Get a cell.
        cell = collectionView.dequeueReusableCellWithReuseIdentifier("CountdownCell", forIndexPath: indexPath) as! UICollectionViewCell
        
        let countdown = countdowns[indexPath.row]
        
        // TODO: Get the correct image for the circle.
        
        // Convert the countdown's colour property to an actual colour.
        backgroundColour = countdown.getColour()
        
        // Put the countdown's name in the view.
        let nameLabel = cell.viewWithTag(2) as! UILabel
        nameLabel.text = countdown.name
        
        // Put the number of days in the view.
        let daysLabel = cell.viewWithTag(3) as! UILabel
        let days = countdown.daysFromNow()
        daysLabel.text = "\(days)"
        
        // Set up the circular icon view with the correct background colour and the correct icon,
        // as retrieved earlier.
        let imageView = cell.viewWithTag(1)!
        imageView.backgroundColor = backgroundColour
        
        return cell
    }
    
    
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        // TODO: Perform a segue to the single-item view or editing view.
    }
    
}
