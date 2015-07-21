//
//  RoundedCornerImageView.swift
//  Sleeps
//
//  Created by Josh Asch on 21/07/2015.
//  Copyright © 2015 Bearhat. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView {
    
    /// Called whenever the view is being redrawn or new subviews have been added. This is where the
    /// corner radius property is updated.
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
    }
    
}
