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
            // Whenever our array of countdowns changes, reload the table view data.
            tableView?.reloadData()
        }
        
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

    
    
    
    // MARK: - View controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - Navigation controller
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Choose what to do based on the segue being performed.
        if segue.identifier! == kNewCountdownSegueIdentifier {
            // The New button was tapped.
        } else if segue.identifier == kEditCountdownSegueIdentifier {
            // Deselect the chosen cell so that it doesn't stay selected after the edit view is
            // dismissed.
            self.tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow!, animated: false)
            
            // Get the countdown object from the table cell and pass it to the edit view.
            let cell = sender as! CountdownTableCell
            let editViewController = segue.destinationViewController as! EditTableViewController
            editViewController.countdown = cell.countdown
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
