//
//  CountdownTableCell.swift
//  Sleeps
//
//  Created by Josh Asch on 21/07/2015.
//  Copyright © 2015 Bearhat. All rights reserved.
//

import UIKit

class CountdownTableCell: UITableViewCell {
    
    @IBOutlet weak var iconView: CircularImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    
    var countdown: Countdown? {
        didSet {
            // Whenever the countdown for the cell is changed, update the subviews.
            guard let countdown = countdown else { return }
            
            // Set the icon on the left.
            iconView.image = Countdown.getDisplayableIconImage(countdown.icon.integerValue)
            iconView.tintColor = .whiteColor()
            iconView.backgroundColor = countdown.uiColour
            
            // Set the name and date.
            nameLabel.text = countdown.name
            dateLabel.text = countdown.date.localisedString()
            
            // If the countdown is in the past, do not show anything in the days label, to avoid
            // accidentally showing a negative number.
            if countdown.daysFromNow() < 0 {
                daysLabel.text = ""
            }
            else {
                // Format the number of days nicely with a thousands separator if necessary.
                let formatter = NSNumberFormatter()
                formatter.locale = NSLocale.currentLocale()
                formatter.numberStyle = .DecimalStyle
                formatter.maximumFractionDigits = 0
                daysLabel.text = formatter.stringFromNumber(countdown.daysFromNow())
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Ensure the icon view does not disappear during selection.
        guard let countdown = countdown else { return }
        iconView.backgroundColor = countdown.uiColour
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        // Ensure the icon view does not disappear during highlight.
        guard let countdown = countdown else { return }
        iconView.backgroundColor = countdown.uiColour
    }

}
