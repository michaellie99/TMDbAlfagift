//
//  NowPlayingResponse.swift
//  TMDbAlfagift
//
//  Created by Michael Lie on 17/09/22.
//

import Foundation


class NowPlayingResponse: Decodable {
    let page: Int
    let results: [MovieInfo]
    let totalPages: Int
    let totalResults: Int
}
