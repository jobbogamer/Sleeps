//
//  AutoLayoutCollectionViewCell.swift
//  Sleeps
//
//  Created by Josh Asch on 26/05/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit

class AutoLayoutCollectionViewCell: UICollectionViewCell {
    
    // Turn off autoresizing mask constraints on the cell's contentView, and add autolayout
    // constraints to the cell's content view which specify that the content view should be exactly
    // the same size as the cell itself. We have to do this, even though it should be the default
    // behaviour, because we turned off autoresizing mask constraints, which causes the content view
    // to have size zero by zero if no constraints are manually added.
    override func updateConstraints()
    {
        // Turn off autoresizing mask contraints.
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints to the contentView to say that it must match the size of the cell.
        let options = NSLayoutFormatOptions()
        let views: [String: AnyObject] = ["contentView": contentView]
        let hConstraints = NSLayoutConstraint.constraintsWithVisualFormat("|[contentView]|", options: options, metrics: nil, views: views)
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[contentView]|", options: options, metrics: nil, views: views)
        addConstraints(hConstraints + vConstraints)
        
        // Let super handle the rest.
        super.updateConstraints()
    }
    
}
