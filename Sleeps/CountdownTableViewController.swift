//
//  CountdownTableViewController.swift
//  Sleeps
//
//  Created by Josh Asch on 21/07/2015.
//  Copyright © 2015 Bearhat. All rights reserved.
//

import UIKit

class CountdownTableViewController: UITableViewController {
    
    /// Persistence controller passed in from the AppDelegate at launch.
    var persistenceController: PersistenceController?
    
    /// Array of Countdown objects from the database, used as the data for the table view.
    var countdowns = [Countdown]() {
        
        didSet {
            // Whenever our array of countdowns changes, reload the table view data, as long as an
            // edit isn't in progress.
            if !modifying {
                tableView?.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
            }
        }
        
    }
    
    /// Is a countdown currently being deleted?
    var modifying = false
    
    
    /// Called when the new countdown button is tapped. Creates a new countdown object with
    /// placeholder values.
    @IBAction func newTapped(sender: UIBarButtonItem) {
        if let persistenceController = persistenceController {
            if let objectContext = persistenceController.managedObjectContext {
                let newCountdown = Countdown.createObjectInContext(objectContext)
                newCountdown.icon = 0
                newCountdown.colour = 0
                newCountdown.name = ""
                newCountdown.date = NSDate(timeIntervalSinceReferenceDate: 0)
                newCountdown.setRepeatInterval(.Never)
                
                // Add the new countdown to the list, save the object context, and then return.
                modifying = true
                countdowns.insert(newCountdown, atIndex: 0)
                persistenceController.save()
                modifying = false
                
                // Automatically enter the edit view, because there's no point having a countdown
                // that just says "New Countdown".
                performSegueWithIdentifier(kNewCountdownSegueIdentifier, sender: self)
                
                // Return so that the error condition code is not reached.
                return
            }
        }
        
        // If we reach this point, the database is catastrophically broken.
        NSLog("No managed object context available to create new countdown")
    }
    
    
    
    
    // MARK: - Database
    
    /// Get all the countdowns from the persistence controller and store them in the countdowns
    /// array. This function only does anything if the persistence controller exists.
    func reloadData() {
        // Use FetchRequestController to get all the countdowns from the database. If no error
        // occurs, set `self.countdowns` to the returned results, which will trigger the collection
        // view to refresh itself.
        if let persistenceController = persistenceController {
            if let fetchedCountdowns = FetchRequestController.getAllObjectsOfType(Countdown.self, fromPersistenceController: persistenceController) {
                var sortedCountdowns = fetchedCountdowns
                sortedCountdowns.sortInPlace(Countdown.isBefore)
                self.countdowns = sortedCountdowns
            }
        }
    }
    
    
    /// Delete the countdown at `index` in the array of countdowns.
    func deleteCountdownAtIndex(index: Int) {
        if let persistenceController = persistenceController {
            if let objectContext = persistenceController.managedObjectContext {
                modifying = true
                objectContext.deleteObject(countdowns[index])
                countdowns.removeAtIndex(index)
                tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Automatic)
                persistenceController.save()
                modifying = false
            }
        }
    }
    
    
    
    // MARK: - View controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - Navigation controller
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Choose what to do based on the segue being performed.
        if segue.identifier! == kNewCountdownSegueIdentifier {
            // The New button was tapped. Assume that the new countdown was added at the front of
            // the array of countdowns.
            let editViewController = segue.destinationViewController as! EditTableViewController
            editViewController.countdown = countdowns[0]
            editViewController.persistenceController = persistenceController
        }
        else if segue.identifier == kEditCountdownSegueIdentifier {
            // Deselect the chosen cell so that it doesn't stay selected after the edit view is
            // dismissed.
            self.tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow!, animated: false)
            
            // Get the countdown object from the table cell and pass it to the edit view.
            let cell = sender as! CountdownTableCell
            let editViewController = segue.destinationViewController as! EditTableViewController
            editViewController.countdown = cell.countdown
            editViewController.persistenceController = persistenceController
        }
    }
    
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue) {
        // There's a bug in iOS which means that using an exit segue doesn't automatically exit from
        // the presented view controller, so dismiss it manually.
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    
    
    // MARK: - Table view

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // There is always only one section.
        return 1
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // There is one row for each countdown.
        return countdowns.count
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get a countdown cell.
        let cell = tableView.dequeueReusableCellWithIdentifier(kCountdownTableCellIdentifier, forIndexPath: indexPath) as! CountdownTableCell

        // Give the cell a countdown to display.
        cell.countdown = countdowns[indexPath.row]

        return cell
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the countdown from the row being deleted.
            deleteCountdownAtIndex(indexPath.row)
        }
    }

}
