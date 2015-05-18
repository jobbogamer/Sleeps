//
//  CircularView.swift
//  Sleeps
//
//  Created by Josh Asch on 18/05/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit

/// A UIView which is circular. That is, it has a corner radius of 50%. The corner radius property
/// will automatically update whenever the view is resized, keeping it consistently circular.
class CircularView : UIView {
    
    /// Called whenever the view is being redrawn or new subviews have been added. This is where the
    /// corner radius property is updated.
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
    }
    
}
