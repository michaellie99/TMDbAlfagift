//
//  ReviewTableViewCell.swift
//  TMDbAlfagift
//
//  Created by Michael Lie on 17/09/22.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewContentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(_ review: Review){
        reviewContentLabel.text = review.content
    }
}
