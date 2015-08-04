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
            // TODO: Set the icon image.
            iconView.backgroundColor = countdown.uiColour
            
            // Set the name.
            nameLabel.text = countdown.name
            
            // If a date is set, display the date and number of days. Otherwise, just display a
            // placeholder.
            if countdown.date.timeIntervalSinceReferenceDate == 0 {
                dateLabel.text = "No date set"
                dateLabel.textColor = UIColor(red: 1, green: 0.4, blue: 0.4, alpha: 1)
                daysLabel.text = ""
            }
            else {
                dateLabel.text = countdown.date.localisedString()
                
                // Format the number of days nicely.
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
