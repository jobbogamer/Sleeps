//
//  CountdownCell.swift
//  Sleeps
//
//  Created by Josh Asch on 20/05/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit


class CountdownCell: UICollectionViewCell {
    
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
    
    
    /// Update the icon and labels with the countdown's properties.
    private func updateView()
    {
        iconView.backgroundColor = countdown.getColour()
        nameLabel.text           = countdown.name
        daysLabel.text           = String(countdown.daysFromNow())
        
        // TODO: Set the icon.
    }
    
    
    // Turn off autoresizing mask constraints on the cell's contentView, and add autolayout
    // constraints to the cell's content view which specify that the content view should be exactly
    // the same size as the cell itself. We have to do this, even though it should be the default
    // behaviour, because we turned off autoresizing mask constraints, which causes the content view
    // to have size zero by zero if no constraints are manually added.
    override func updateConstraints()
    {
        // Turn off autoresizing mask contraints.
        contentView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Add constraints to the contentView to say that it must match the size of the cell.
        let options = NSLayoutFormatOptions.allZeros
        let views: [NSObject: AnyObject] = ["contentView": contentView, "background": background]
        let hConstraints = NSLayoutConstraint.constraintsWithVisualFormat("|[contentView]|", options: options, metrics: nil, views: views)
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[contentView]|", options: options, metrics: nil, views: views)
        addConstraints(hConstraints + vConstraints)
        
        // Add constraints to the background view to say that it must match the size of its parent,
        // otherwise it will also collapse.
        let backgroundHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("|[background]|", options: options, metrics: nil, views: views)
        let backgroundVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[background]|", options: options, metrics: nil, views: views)
        addConstraints(backgroundHConstraints + backgroundVConstraints)
        
        // Let super handle the rest.
        super.updateConstraints()
    }
}
