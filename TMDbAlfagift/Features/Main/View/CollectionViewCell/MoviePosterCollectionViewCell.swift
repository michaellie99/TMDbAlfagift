//
//  MoviePosterCollectionViewCell.swift
//  TMDbAlfagift
//
//  Created by Michael Lie on 17/09/22.
//

import UIKit
import Kingfisher

class MoviePosterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    func setCell(_ info: MovieInfo){
        let path = info.posterPath ?? ""
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
        let processor = RoundCornerImageProcessor(cornerRadius: 16)
        imageView.contentMode = .scaleAspectFit
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"),options: [.processor(processor)])
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
