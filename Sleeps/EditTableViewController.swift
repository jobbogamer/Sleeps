//
//  EditTableViewController.swift
//  Sleeps
//
//  Created by Josh Asch on 02/08/2015.
//  Copyright © 2015 Bearhat. All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController, UITextFieldDelegate {
    
    /// The persistence controller that the countdown comes from.
    var persistenceController: PersistenceController?
    
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
    
    
    
    // MARK: - Outlets
    
    /// The image view in the top left for choosing an icon.
    @IBOutlet weak var iconChooser: UIImageView!
    
    /// The image view in the top right for choosing a background colour.
    @IBOutlet weak var colourChooser: CircularImageView!
    
    /// The name of the countdown.
    @IBOutlet weak var nameField: UITextField!
    
    /// The button which displays the date of the countdown and shows the date chooser when tapepd.
    @IBOutlet weak var dateChooser: UIButton!
    
    /// The segmented button used to control repeats.
    @IBOutlet weak var repeatChooser: UISegmentedControl!
    
    
    
    // MARK: - Text field
    
    func textFieldDidEndEditing(textField: UITextField) {
        // Set the name of the countdown using the text in the text field, then save.
        let newName = textField.text!
        countdown?.name = newName
        persistenceController?.save()
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Dismiss the keyboard when the return key is pressed.
        textField.resignFirstResponder()
        return true
    }
    
    
    
    // MARK: - View controller

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The table view must be given a nil background view otherwise the navigation controller
        // transition will break and the table view will have a white background.
        tableView.backgroundView = nil
        
        // Set the colour of the placeholder text in the name text field.
        nameField.attributedPlaceholder = NSAttributedString(string: "Sleeps 'til...",
            attributes: [NSForegroundColorAttributeName: kPlaceholderFontColour])
        
        // Set the font of the date chooser text.
        dateChooser.titleLabel?.font = UIFont.systemFontOfSize(18)
        
        // Set the text and font colour of the date chooser based on whether the date is using a
        // placeholder.
        let dateColour: UIColor
        let dateString: String
        if let countdown = countdown {
            if countdown.date.timeIntervalSinceReferenceDate == 0 {
                dateColour = kPlaceholderFontColour
                dateString = "...when?"
            }
            else {
                dateColour = UIColor.blackColor()
                dateString = countdown.date.localisedString()
            }
            
            dateChooser.setAttributedTitle(NSAttributedString(string: dateString,
                attributes: [NSForegroundColorAttributeName: dateColour]), forState: .Normal)
        }
        
        // Set up the outlets with the details of the countdown that has been passed in.
        updateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Bar button items
    
    /// Called when the delete button is tapped. Shows a sheet offering two options, delete and
    /// cancel.
    @IBAction func deleteTapped(sender: UIBarButtonItem) {
        
    }
    
    /// Called when the share button is tapped. Shows the system share sheet for sharing information
    /// about the countdown.
    @IBAction func sharePressed(sender: UIBarButtonItem) {
        
    }
    
}
