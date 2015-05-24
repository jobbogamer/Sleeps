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
    var countdown: Countdown!
    
    /// The Edit button in the bottom left.
    @IBOutlet weak var editButton: RoundedCornerButton!
    
    /// The Share button in the bottom right.
    @IBOutlet weak var shareButton: RoundedCornerButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Give the Edit and Share buttons an outline.
        editButton.layer.borderColor  = kGlobalTintColour.CGColor
        editButton.layer.borderWidth  = 1
        shareButton.layer.borderColor = kGlobalTintColour.CGColor
        shareButton.layer.borderWidth = 1
    }

}

