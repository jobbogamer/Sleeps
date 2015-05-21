//
//  Constants.swift
//  Sleeps
//
//  Created by Josh Asch on 21/05/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit

/* General ****************************************************************************************/

/// Global tint colour used for buttons, etc.
let kGlobalTintColour: UIColor = UIColor(red:0.061, green:0.715, blue:0.374, alpha:1)


/* CountdownCollectionView ************************************************************************/

/// The identifier of the segue from the countdown collection view to the New Countdown screen.
let kNewCountdownSegueIdentifier: String = "NewCountdown"

/// The identifier for countdown cells.
let kCountdownCellIdentifier: String = "CountdownCell"

/// The spacing, in points, between collection view cells.
let kCollectionViewItemSpacing: CGFloat = 2

/// The spacing, in points, between collection view cells and the edge of the screen.
let kCollectionViewOuterMargin: CGFloat = 0

/// Border width, in points, for collection view cells.
let kCollectionViewItemBorderWidth: CGFloat = 0

/// Border colour for collection view cells.
let kCollectionViewItemBorderColour: UIColor = UIColor.lightGrayColor()