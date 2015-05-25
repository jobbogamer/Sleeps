//
//  ViewController.swift
//  Sleeps
//
//  Created by Josh Asch on 30/03/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    /// The countdown that's being edited.
    var countdown: Countdown! {
        didSet
        {
            // Whenever the countdown is changed, update the view.
            updateView()
        }
    }
    
    /// The circular icon view at the top.
    @IBOutlet weak var iconView: CircularView!
    
    /// The name text field.
    @IBOutlet weak var nameField: UITextField!
    
    /// The label which shows the actual count.
    @IBOutlet weak var daysLabel: UILabel!
    
    /// The button which displays the date of the countdown.
    @IBOutlet weak var dateButton: UIButton!
    
    /// The button which displays the repeat interval.
    @IBOutlet weak var repeatButton: UIButton!
    
    /// The Edit button in the bottom left.
    @IBOutlet weak var editButton: RoundedCornerButton!
    
    /// The Share button in the bottom right.
    @IBOutlet weak var shareButton: RoundedCornerButton!
    
    
    private func updateView()
    {
        // Set up all the fields and buttons in the view.
        iconView?.backgroundColor = countdown.getColour()
        nameField?.text = countdown.name
        daysLabel?.text = String(countdown.daysFromNow())
        dateButton?.setTitle(countdown.date.localisedString(), forState: .Normal)
        repeatButton?.setTitle(countdown.repeatIntervalString(), forState: .Normal)
        
        // TODO: Set the icon.
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Give the Edit and Share buttons an outline.
        editButton.layer.borderColor  = kGlobalTintColour.CGColor
        editButton.layer.borderWidth  = 1
        shareButton.layer.borderColor = kGlobalTintColour.CGColor
        shareButton.layer.borderWidth = 1
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Whenever the view is about to appear, update the fields.
        updateView()
    }

}

