//
//  Review.swift
//  TMDbAlfagift
//
//  Created by Michael Lie on 17/09/22.
//

import Foundation


struct GetReviewsResponse: Codable {
    let id: Int
    let page: Int
    let reviews: [Review]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case id
        case page
        case reviews = "results"
        case totalPages
        case totalResults
    }
}

struct Review: Codable {
    let author: String
    let content: String
    let createdAt: String
}
