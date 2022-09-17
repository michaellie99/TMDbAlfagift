//
//  MovieInfo.swift
//  TMDbAlfagift
//
//  Created by Michael Lie on 17/09/22.
//

import Foundation

class MovieInfo: Codable {
    let posterPath: String?
    let releaseDate: String
    let voteAverage: Float
    let popularity: Float
    let id: Int
    let title: String
    let overview: String
}
