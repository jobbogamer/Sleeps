//
//  ButtonsCell.swift
//  Sleeps
//
//  Created by Josh Asch on 26/05/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit

class ButtonsCell: AutoLayoutCollectionViewCell {
    
    @IBOutlet weak var background:     RoundedCornerView!
    @IBOutlet weak var newButton:      CapsuleButton!
    @IBOutlet weak var settingsButton: CapsuleButton!
    
    
    /// Set up the visual properties of the cell.
    func setUp()
    {
        // Give the buttons a 1pt outline, using the global tint colour.
        newButton.layer.borderColor      = kGlobalTintColour.CGColor
        newButton.layer.borderWidth      = 1
        settingsButton.layer.borderColor = kGlobalTintColour.CGColor
        settingsButton.layer.borderWidth = 1
    }
}
