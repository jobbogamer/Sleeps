//
//  RoundedCornerView.swift
//  Sleeps
//
//  Created by Josh Asch on 19/05/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit

class RoundedCornerView: UIView {
    
    /// The radius of the corners in points.
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = (cornerRadius > 0)
        }
    }
    
}

