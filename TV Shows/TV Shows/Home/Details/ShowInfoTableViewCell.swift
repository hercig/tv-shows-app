//
//  ShowInfoTableViewCell.swift
//  TV Shows
//
//  Created by Filip Hercig on 29.07.2021..
//

import UIKit

class ShowInfoTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var showDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with show: Show) {
        showDescription.text = show.description
    }
}
