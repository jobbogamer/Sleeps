//
//  UIEdgeInsets+Helpers.swift
//  Sleeps
//
//  Created by Josh Asch on 19/05/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    
    static func InsetsWithEqualSize(size: CGFloat) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(size, size, size, size)
    }
    
}
