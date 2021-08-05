//
//  WriteReviewTableViewCell.swift
//  TV Shows
//
//  Created by Filip Hercig on 05.08.2021..
//

import UIKit

class WriteReviewTableViewCell: UITableViewCell {

    @IBOutlet private weak var writeReviewButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        writeReviewButton.layer.cornerRadius = 21.5
        writeReviewButton.clipsToBounds = true
    }
}
