//
//  RoundedCornerView.swift
//  Sleeps
//
//  Created by Josh Asch on 18/05/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit

class RoundedCornerButton: UIButton {

    /// The radius of the corners in points.
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = (cornerRadius > 0)
        }
    }
}
