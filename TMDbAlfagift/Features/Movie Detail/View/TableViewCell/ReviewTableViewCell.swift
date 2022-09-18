//
//  ReviewTableViewCell.swift
//  TMDbAlfagift
//
//  Created by Michael Lie on 17/09/22.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var seeMoreLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reviewContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(_ review: Review){
        containerView.roundViewCorner(cornerRadius: 16, borderWidth: 1, borderColor: UIColor(red: 0.9137, green: 0, blue: 0.9294, alpha: 1.0))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        if let date = formatter.date(from: review.createdAt){
            formatter.dateFormat = "EEEE, MMM d, yyyy"
            dateLabel.text = formatter.string(from: date)
        }else{
            dateLabel.text = ""
        }
        authorLabel.text = review.author
        reviewContentLabel.text = review.content
        seeMoreLabel.isHidden = !reviewContentLabel.isTruncated
    }
}
