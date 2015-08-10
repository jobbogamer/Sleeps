//
//  ColourChooserViewController.swift
//  Sleeps
//
//  Created by Josh Asch on 10/08/2015.
//  Copyright © 2015 Bearhat. All rights reserved.
//

import UIKit

class ColourChooserViewController: UIViewController {
    
    /// The circular views which represent the available colours.
    @IBOutlet var colourViews: [CircularImageView]!
    
    /// The view controller which presented the popover.
    var presentingView: UIViewController!
    
    
    /// Called when a circular view is tapped.
    func colourViewTapped(sender: UITapGestureRecognizer) {
        for (index, view) in colourViews.enumerate() {
            if view == sender.view {
                if let editView = presentingView as? EditTableViewController {
                    editView.countdown?.colour = index
                    editView.persistenceController?.save()
                    editView.colourChooser.backgroundColor = Countdown.colourFromIndex(index)
                    dismissViewControllerAnimated(true, completion: nil)
                }
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add a gesture recogniser to each colour view and set its colour.
        for (index, view) in colourViews.enumerate() {
            let gesture = UITapGestureRecognizer(target: self, action: "colourViewTapped:")
            view.userInteractionEnabled = true
            view.addGestureRecognizer(gesture)
            
            let colour = Countdown.colourFromIndex(index)
            view.backgroundColor = colour
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
