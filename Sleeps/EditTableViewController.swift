//
//  EditTableViewController.swift
//  Sleeps
//
//  Created by Josh Asch on 02/08/2015.
//  Copyright © 2015 Bearhat. All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController {
    
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
    
    
    
    // MARK: - View controller

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = nil
        
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
