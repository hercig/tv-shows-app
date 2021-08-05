//
//  ShowInfoTableViewCell.swift
//  TV Shows
//
//  Created by Filip Hercig on 29.07.2021..
//

import UIKit

class ShowInfoTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var showDescription: UILabel!
    @IBOutlet private weak var averageRating: UILabel!
    @IBOutlet private weak var ratingView: RatingView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ratingView.configure(withStyle: .large)
        ratingView.isEnabled = false
    }
    
    func configure(with show: Show) {
        showDescription.text = show.description
        ratingView.setRoundedRating(Double(show.averageRating ?? 0))
        if show.noOfReviews != 0 {
            if let avgRating = show.averageRating {
                let text = String(describing: show.noOfReviews) + " REVIEWS, " + String(describing: avgRating) + " AVERAGE"
                averageRating.text = text
            }
        } else {
            
        }
    }
}
