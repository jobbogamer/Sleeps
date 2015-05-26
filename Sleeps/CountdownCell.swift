//
//  CountdownCell.swift
//  Sleeps
//
//  Created by Josh Asch on 20/05/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit


class CountdownCell: AutoLayoutCollectionViewCell {
    
    @IBOutlet weak var background: RoundedCornerView!
    @IBOutlet weak var iconView:   CircularView!
    @IBOutlet weak var nameLabel:  UILabel!
    @IBOutlet weak var daysLabel:  UILabel!
    
    var countdown: Countdown! {
        didSet
        {
            // Whenever the countdown is modified, update the view with its new properties.
            updateView()
        }
    }
    
    
    /// Set up the visual properties of the cell.
    func setUp()
    {
        layer.borderWidth = kCollectionViewItemBorderWidth
        layer.borderColor = kCollectionViewItemBorderColour.CGColor
    }
    
    
    /// Update the icon and labels with the countdown's properties.
    private func updateView()
    {
        iconView.backgroundColor = countdown.getColour()
        nameLabel.text           = countdown.name
        daysLabel.text           = String(countdown.daysFromNow())
        
        // TODO: Set the icon.
    }
}
