//
//  ReviewDetailViewModel.swift
//  TMDbAlfagift
//
//  Created by Michael Lie on 18/09/22.
//

import Foundation
import RxSwift

struct ReviewDetailViewModel{
    let author: String
    let reviewDate: String
    let content: String
    
    init(_ review: Review){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        if let date = formatter.date(from: review.createdAt){
            formatter.dateFormat = "EEEE, MMM d, yyyy"
            reviewDate = formatter.string(from: date)
        }else{
            reviewDate = ""
        }
        author = review.author
        content = review.content
    }
}
