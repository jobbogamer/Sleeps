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
let kGlobalTintColour: UIColor = UIColor(red: 192, green: 95, blue: 193)

/// Font colour for placeholder text.
let kPlaceholderFontColour: UIColor = UIColor(white: 0.7, alpha: 1)


/* Navigation Controller***************************************************************************/

/// Whether the navigation bar should be filled with a background colour.
let kNavigationBarFilled: Bool = false

/// Whether the toolbar should be filled with a background colour.
let kToolbarFilled: Bool = false

/// Background colour to give to the navigation bar.
let kNavigationControllerBarColour: UIColor = kGlobalTintColour

/// Background colour to give to the toolbar.
let kToolbarColour: UIColor = .whiteColor()

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

/// The identifier of the segue from the edit screen to the date picker.
let kDateChooserSegueIdentifier: String = "ChooseDate"

/// The identifier of the segue from the edit screen to show the colour chooser popover.
let kColourChooserSegueIdentifier: String = "ChooseColour"

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


/* Edit View **************************************************************************************/

/// Height of the date picker.
let kDatePickerHeight: CGFloat = 216.0
