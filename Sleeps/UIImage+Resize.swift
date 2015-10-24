//
//  UIImage+Resize.swift
//  Sleeps
//
//  Created by Josh Asch on 24/10/2015.
//  Copyright © 2015 Bearhat. All rights reserved.
//

import UIKit


extension UIImage {
    
    func scaleToSize(newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
