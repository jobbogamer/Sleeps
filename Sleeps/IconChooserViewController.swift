//
//  IconChooserViewController.swift
//  Sleeps
//
//  Created by Josh Asch on 30/08/2015.
//  Copyright © 2015 Bearhat. All rights reserved.
//

import UIKit

class IconChooserViewController: UIViewController {
    
    /// The icons to display in the chooser.
    let icons = [
        // Page 1, row 1
        R.image.calendar,
        R.image.clock,
        R.image.star,
        
        // Page 1, row 2
        R.image.heart,
        R.image.present,
        R.image.christmastree,
        
        // Page 1, row 3
        R.image.shoppingbag,
        R.image.sun,
        R.image.suitcase,
        
        // Page 2, row 1
        R.image.briefcase,
        R.image.university,
        R.image.house,
        
        // Page 2, row 2
        R.image.music,
        R.image.film,
        R.image.tv,
        
        // Page 2, row 3
        R.image.controller,
        R.image.cinema,
        R.image.ticket,
        
        // Page 3, row 1
        R.image.iphone,
        R.image.ipad,
        R.image.laptop,
        
        // Page 3, row 2
        R.image.desktop,
        R.image.headphones,
        R.image.coffee,
        
        // Page 3, row 3
        R.image.presentation,
        R.image.envelope,
        R.image.handbag,        
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
