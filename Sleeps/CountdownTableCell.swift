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
            
            // Find the correct size for the icon, so that it fits in the circle and keeps the
            // correct aspect ratio.
            let icon = Countdown.icons[countdown.icon.integerValue]
            let targetSize = CGSizeMake(iconView.frame.width - 16, iconView.frame.height - 16)
            let actualSize = calculateCorrectIconSize(icon, targetSize: targetSize)
            
            // Put the icon into the view, scaling it to the size that was just calculated.
            iconView.image = icon?.scaleToSize(actualSize).imageWithRenderingMode(.AlwaysTemplate)
            iconView.backgroundColor = countdown.uiColour
            iconView.tintColor = kIconStrokeColour
            
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
    
    func calculateCorrectIconSize(icon: UIImage?, targetSize: CGSize) -> CGSize {
        // If there's no icon, it doesn't matter what size is used.
        guard let icon = icon else { return targetSize }
        
        let width = icon.size.width
        let height = icon.size.height
        let ratio = width / height
        
        if width > height {
            // If the image is wider than it is tall, the new width should be set to the target
            // width, and the height should be scaled appropriately.
            let newWidth = targetSize.width
            let newHeight = newWidth / ratio
            return CGSizeMake(newWidth, newHeight)
        }
        else if height > width {
            // This is the inverse case to the case above.
            let newHeight = targetSize.height
            let newWidth = newHeight * ratio
            return CGSizeMake(newWidth, newHeight)
        }
        else {
            // If the image already has 1:1 aspect ratio, it can simply be scaled.
            return targetSize
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
