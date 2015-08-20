//
//  EditTableViewController.swift
//  Sleeps
//
//  Created by Josh Asch on 02/08/2015.
//  Copyright © 2015 Bearhat. All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController, UITextFieldDelegate, UIPopoverPresentationControllerDelegate {
    
    /// The persistence controller that the countdown comes from.
    var persistenceController: PersistenceController?
    
    /// Is the date picker showing?
    var datePickerVisible = false
    
    /// Should the countdown be deleted when this view disappears?
    var deleteOnExit = false
    
    /// The countdown being edited.
    var countdown: Countdown? {
        didSet {
            updateView()
        }
    }
    
    
    /// Set all the values in the view with the ones from the countdown passed in.
    func updateView() {
        if let countdown = countdown {
            // TODO: Set the icon chooser.
            colourChooser?.backgroundColor      = countdown.uiColour
            nameField?.text                     = countdown.name
            dateChooser?.setTitle(countdown.date.localisedString(), forState: .Normal)
            repeatChooser?.selectedSegmentIndex = countdown.repeatInterval.integerValue
        }
    }
    
    
    /// Delete the countdown currently being edited, and return to the list of countdowns.
    func deleteCountdownFromAlertAction(alertAction: UIAlertAction) {
        // Get the countdown list and tell it that to delete the countdown.
        let listView = navigationController?.viewControllers[0] as! CountdownTableViewController
        listView.deletedCountdown = true
        
        // Return to the list of countdowns.
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    
    // MARK: - Outlets
    
    /// The image view in the top left for choosing an icon.
    @IBOutlet weak var iconChooser: UIImageView!
    
    /// The image view in the top right for choosing a background colour.
    @IBOutlet weak var colourChooser: CircularImageView!
    
    /// The name of the countdown.
    @IBOutlet weak var nameField: UITextField!
    
    /// The button which displays the date of the countdown and shows the date chooser when tapepd.
    @IBOutlet weak var dateChooser: UIButton!
    
    /// The actual date picker.
    @IBOutlet weak var datePicker: UIDatePicker!
    
    /// The height of the date picker.
    @IBOutlet weak var datePickerHeightConstraint: NSLayoutConstraint!
    
    /// The segmented button used to control repeats.
    @IBOutlet weak var repeatChooser: UISegmentedControl!
    
    
    
    
    // MARK: - Table view
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 2 && indexPath.row == 1 {
            return datePickerVisible ? kDatePickerHeight : 0
        }
        else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 0 && indexPath.section == 0 {
            return false
        }
        else {
            return true
        }
    }
    
    
    
    
    // MARK: - Text field
    
    func textFieldDidEndEditing(textField: UITextField) {
        // Set the name of the countdown using the text in the text field, then save.
        let newName = textField.text!
        countdown?.name = newName
        persistenceController?.save()
        
        // The countdown has now been edited, so don't delete it on exit unless no name was entered.
        deleteOnExit = (deleteOnExit && newName.length == 0)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Dismiss the keyboard when the return key is pressed.
        textField.resignFirstResponder()
        return true
    }
    
    
    
    // MARK: - Segmented control
    
    /// Called when the repeat interval chooser changes value. Update the repeat interval of the
    /// countdown being edited and save it back to the database.
    func segmentedControlValueDidChange(segmentedControl: UISegmentedControl) {
        countdown?.repeatInterval = repeatChooser.selectedSegmentIndex
        persistenceController?.save()
    }
    
    
    
    
    // MARK: - Date chooser
    
    @IBAction func dateChooserTapped(sender: UIButton) {
        // Toggle whether the date picker is visible. This will determine the height of the cell
        // containing the date picker - see tableView(_:willDisplayCell:forRowAtIndexPath:)
        datePickerVisible = !datePickerVisible
        
        // This will force the table view to animate any cell height changes.
        tableView.beginUpdates()
        tableView.endUpdates()
        
        // Scroll so that the date picker is centered on screen. If it has just been collapsed, this
        // will do nothing as there isn't enough content in the table to make it scrollable.
        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 2), atScrollPosition: .Middle, animated: true)
    }
    
    @IBAction func datePickerValueDidChange(sender: UIDatePicker) {
        guard let countdown = countdown else { return }
        
        // Update and save the countdown's date.
        countdown.date = datePicker.date
        persistenceController?.save()
        
        // Update the visible date in the chooser.
        dateChooser.setTitle(countdown.date.localisedString(), forState: .Normal)
    }
    
    
    
    
    // MARK: - Colour chooser
    
    /// When the colour chooser circle is tapped, perform the segue to show the popover.
    func colourChooserTapped() {
        performSegueWithIdentifier(kColourChooserSegueIdentifier, sender: self)
    }
    
    
    
    
    // MARK: - Popover delegate
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Always use a popover, never fullscreen.
        return .None
    }
    
    
    
    
    // MARK: - View controller

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The table view must be given a nil background view otherwise the navigation controller
        // transition will break and the table view will have a white background.
        tableView.backgroundView = nil
        
        // Register the callback for when the repeat interval chooser changes value.
        repeatChooser.addTarget(self, action: "segmentedControlValueDidChange:", forControlEvents: .ValueChanged)
        
        // Set the dates in the date picker.
        if let countdown = countdown {
            datePicker.date = countdown.date
            datePicker.minimumDate = NSDate()
        }
        
        // Add a gesture recogniser to the colour chooser image view.
        colourChooser.userInteractionEnabled = true
        let colourGesture = UITapGestureRecognizer(target: self, action: "colourChooserTapped")
        colourChooser.addGestureRecognizer(colourGesture)
        
        // Set up the outlets with the details of the countdown that has been passed in.
        updateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Delete the countdown if required.
        if deleteOnExit {
            guard let countdown = countdown,
                let objectContext = persistenceController?.managedObjectContext
                else { return }
            
            objectContext.deleteObject(countdown)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == kColourChooserSegueIdentifier {
            if let colourPopoverController = segue.destinationViewController as? ColourChooserViewController {
                colourPopoverController.popoverPresentationController?.delegate = self
                colourPopoverController.preferredContentSize = CGSize(width: 320, height: 320)
                colourPopoverController.presentingView = self
            }
        }
    }
    
    
    
    
    // MARK: - Bar button items
    
    /// Called when the delete button is tapped. Shows a sheet offering two options, delete and
    /// cancel.
    @IBAction func deleteTapped(sender: UIBarButtonItem) {
        // Create the Delete option.
        let deleteAction = UIAlertAction(title: "Delete Countdown", style: .Destructive, handler: deleteCountdownFromAlertAction)
        
        // Create the Cancel option.
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        // Create the action sheet, add the actions to it, and display it.
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    /// Called when the share button is tapped. Shows the system share sheet for sharing information
    /// about the countdown.
    @IBAction func sharePressed(sender: UIBarButtonItem) {
        
    }
    
}
