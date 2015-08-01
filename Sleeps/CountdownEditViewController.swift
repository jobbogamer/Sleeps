//
//  ViewController.swift
//  Sleeps
//
//  Created by Josh Asch on 30/03/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit

class CountdownEditViewController: UIViewController {
    
    /// The countdown that's being edited.
    var countdown: Countdown! {
        didSet
        {
            // Whenever the countdown is changed, update the view.
            updateView()
        }
    }
    
    /// The Done button in the top right.
    @IBOutlet weak var doneButton: UIButton!
    
    /// The icon view at the top.
    @IBOutlet weak var iconView: UIImageView!
    
    /// The circulr view at the top for changing the colour.
    @IBOutlet weak var colourView: UIImageView!
    
    /// The layout constraint which controls the height of iconVIew.
    @IBOutlet weak var iconViewHeightConstraint: NSLayoutConstraint!
    
    /// The name text field.
    @IBOutlet weak var nameField: UITextField!
    
    /// The button which displays the date of the countdown.
    @IBOutlet weak var dateButton: UIButton!
    
    /// The segmented button used to select the repeat duration.
    @IBOutlet weak var repeatChooser: UISegmentedControl!
    
    /// The Edit button in the bottom left.
    @IBOutlet weak var editButton: RoundedCornerButton!
    
    /// The Share button in the bottom right.
    @IBOutlet weak var shareButton: RoundedCornerButton!
        
    
    private func updateView()
    {
        if let countdown = countdown
        {
            // Set up all the fields and buttons in the view.
            colourView?.backgroundColor = countdown.uiColour
            nameField?.text = countdown.name
            dateButton?.setTitle(countdown.date.localisedString(), forState: .Normal)
            repeatChooser?.selectedSegmentIndex = countdown.repeatInterval.integerValue
            
            // TODO: Set the icon.
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Once support is dropped for the 4s, hopefully that's the end of the 3.5 inch screen size.
        // Until then, the edit view doesn't fit on 3.5 inch screens, so we need to detect that size
        // and shrink the icon view a bit in order to let everything fit on screen.
        if UIScreen.mainScreen().bounds.size.height < 568
        {
            //iconViewHeightConstraint.constant = 70
            //iconView.setNeedsUpdateConstraints()
        }
        
        // Give the Share button an outline.
        shareButton.layer.borderColor = kGlobalTintColour.CGColor
        shareButton.layer.borderWidth = 1
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Whenever the view is about to appear, update the fields.
        updateView()
    }

}

