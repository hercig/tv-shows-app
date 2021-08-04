//
//  ShowReviewsTableViewCell.swift
//  TV Shows
//
//  Created by Filip Hercig on 29.07.2021..
//

import UIKit

class ShowReviewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var commentLabel: UILabel!
    @IBOutlet weak private var commentImage: UIImageView!
    @IBOutlet weak private var commentEmail: UILabel!
    @IBOutlet weak private var ratingView: RatingView!

    override func awakeFromNib() {
        super.awakeFromNib()
        ratingView.configure(withStyle: .small)
        ratingView.isEnabled = false
    }
    
    func configure(with review: Review) {
        commentLabel.text = review.comment
        commentEmail.text = review.user.email
        commentImage.image = UIImage(named: "ic-profile-placeholder")
        ratingView.setRoundedRating(Double(review.rating))
    }
}
