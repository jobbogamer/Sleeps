//
//  IconPageViewController.swift
//  Sleeps
//
//  Created by Josh Asch on 30/08/2015.
//  Copyright © 2015 Bearhat. All rights reserved.
//

import UIKit

class IconPageViewController: UIViewController {
    
    /// The 9 visible views which each contain an icon.
    @IBOutlet var iconViews: [CircularImageView]!
    
    /// The view controller which presented the popover.
    var presentingView: UIViewController!
    
    /// Which page in the page controller is this?
    var pageIndex = 0
    
    /// The icons to display in the iconViews.
    var icons: [UIImage?]! {
        didSet {
            updateIconViews()
        }
    }
    
    
    
    
    // MARK: - Functions
    
    /// Update all the icon views with the icons passed in.
    func updateIconViews() {
        guard let icons = icons else { return }
        guard let iconViews = iconViews else { return }
        
        for (index, view) in iconViews.enumerate() {
            if index < icons.count {
                // Display a tinted version of the image.
                view.image = Countdown.getDisplayableIconImage(index + (9*pageIndex))
                view.tintColor = kGlobalTintColour
            }
        }
    }
    
    
    /// Callback for when an icon is tapped.
    func iconViewTapped(sender: UITapGestureRecognizer) {
        for (index, view) in iconViews.enumerate() {
            if view == sender.view {
                if let editView = presentingView as? EditTableViewController {
                    editView.countdown?.icon = index + (9 * pageIndex)
                    editView.persistenceController?.save()
                    editView.iconChooser.image = Countdown.getDisplayableIconImage(index + (9 * pageIndex))
                    dismissViewControllerAnimated(true, completion: nil)
                }
            }
        }
    }
    
    
    
    
    // MARK: - View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a gesture recogniser to each icon view.
        for view in iconViews {
            let gesture = UITapGestureRecognizer(target: self, action: "iconViewTapped:")
            view.userInteractionEnabled = true
            view.addGestureRecognizer(gesture)
        }
        
        // Load the icons in when the view loads.
        updateIconViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
