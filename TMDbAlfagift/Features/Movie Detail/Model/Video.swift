//
//  Video.swift
//  TMDbAlfagift
//
//  Created by Michael Lie on 17/09/22.
//

import Foundation


struct GetVideoResponse: Codable {
    let id: Int
    let videos: [Video]
    
    enum CodingKeys: String, CodingKey {
        case id
        case videos = "results"
    }
}
struct Video: Codable {
    let key: String
    let site: String
    let type: String
    let official: Bool
    let id: String

}
