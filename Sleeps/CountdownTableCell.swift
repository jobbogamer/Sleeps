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
            iconView.backgroundColor = countdown.uiColour
            nameLabel.text = countdown.name
            dateLabel.text = countdown.date.localisedString()
            daysLabel.text = String(countdown.daysFromNow())
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
