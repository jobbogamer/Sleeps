//
//  UIColor+Utilities.swift
//  Sleeps
//
//  Created by Josh Asch on 27/08/2015.
//  Copyright © 2015 Bearhat. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// Create a colour from `red`, `green`, and `blue` components where each component is an
    /// integer between 0 and 255, rather than a float between 0.0 and 1.0.
    convenience init(red: Int, green: Int, blue: Int) {
        let redF   = CGFloat(red) / 255
        let greenF = CGFloat(green) / 255
        let blueF  = CGFloat(blue) / 255
        
        self.init(red: redF, green: greenF, blue: blueF, alpha: CGFloat(1.0))
    }
    
}
