//
//  CapsuleButton.swift
//  Sleeps
//
//  Created by Josh Asch on 26/05/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit

class CapsuleButton: UIButton {

    override var bounds: CGRect {
        didSet
        {
            layer.cornerRadius = bounds.height / 2
        }
    }

}
