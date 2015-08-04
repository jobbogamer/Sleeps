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
let kGlobalTintColour: UIColor = UIColor(hue:260/360, saturation:50/100, brightness:75/100, alpha:1)

/// Font colour for placeholder text.
let kPlaceholderFontColour: UIColor = UIColor(white: 0.7, alpha: 1)


/* Navigation Controller***************************************************************************/

/// Whether the navigation bar and toolbar should be filled with a background colour.
let kNavigationControllerBarFilled: Bool = false

/// Background colour to give to the navigation bar and toolbar.
let kNavigationControllerBarColour: UIColor = kGlobalTintColour

/// Tint colour used for bar button items and navigation bar titles.
let kNavigationControllerTintColour: UIColor = kGlobalTintColour


/* CountdownCollectionView ************************************************************************/

/// The identifier of the segue from the countdown collection view to the New Countdown screen.
let kNewCountdownSegueIdentifier: String = "NewCountdown"

/// The identifier of the segue from the countdown collection view to the Edit Countdown screen.
let kEditCountdownSegueIdentifier: String = "EditCountdown"

/// The identifier of the segue from the New/Edit screen back to the collection view.
let kDismissCardViewSegueIdentifier: String = "DismissCardView"

/// The identifier of the segue from the countdown collection view to the Settings screen.
let kSettingsScreenSegueIdentifier: String = "ShowSettings"

/// The identifier for countdown cells.
let kCountdownCellIdentifier: String = "CountdownCell"

/// The identifier for countdown cells in a Table View.
let kCountdownTableCellIdentifier: String = "CountdownTableCell"

/// The identifier for the collection view cell with the New and Settings buttons.
let kButtonsCellIdentifier: String = "ButtonsCell"

/// The spacing, in points, between collection view cells.
let kCollectionViewItemSpacing: CGFloat = 2

/// The spacing, in points, between collection view cells and the edge of the screen.
let kCollectionViewOuterMargin: CGFloat = 0

/// Border width, in points, for collection view cells.
let kCollectionViewItemBorderWidth: CGFloat = 0

/// Border colour for collection view cells.
let kCollectionViewItemBorderColour: UIColor = UIColor.lightGrayColor()