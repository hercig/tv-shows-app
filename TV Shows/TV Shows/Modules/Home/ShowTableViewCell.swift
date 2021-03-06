//
//  ShowTableViewCell.swift
//  TV Shows
//
//  Created by Filip Hercig on 29.07.2021..
//

import UIKit
import Kingfisher

class ShowTableViewCell: UITableViewCell {
    
    var show: Model.Show!
    
    @IBOutlet private weak var showTitle: UILabel!
    @IBOutlet private weak var showImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with show: Model.Show) {
        self.show = show
        showTitle.text = show.title
        let imageUrl = show.imageUrl
        showImage.kf.setImage(
            with: imageUrl,
            placeholder: UIImage(named: "ic-show-placeholder-vertical")
        )
    }
}
