//
//  MovieDetailViewModel.swift
//  TMDbAlfagift
//
//  Created by Michael Lie on 17/09/22.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel{
    var id: Int = -1
    var videoId = ""
    var imageUrl = ""
    
    let isReviewHidden = PublishRelay<Bool>()
    var reviewList = BehaviorRelay<[Review]>(value: [])
    let title = BehaviorRelay<String>(value: "")
    let overview = BehaviorRelay<String>(value: "")
    
    func getVideos(completion: @escaping ()->()){
        TheNetworkManager.getVideos(id: id) { [unowned self] data in
            if let data = data{
                if !data.videos.isEmpty{
                    for video in data.videos{
                        if video.type == "Trailer"{
                            videoId = video.key
                            completion()
                        }
                    }
                }
            }
        }
    }
    func getMovieDetail(error: (()->Void)?){
        TheNetworkManager.getMovieDetail(id: id) { [unowned self] data in
            if let data = data{
                title.accept(data.title)
                overview.accept(data.overview)
            }else{
                error!()
            }
        }
    }
    func getReviews(error: (()->Void)?){
        TheNetworkManager.getReviews(id: id) {  [unowned self] data in
            if let data = data{
                reviewList.accept(data.reviews)
                isReviewHidden.accept(!data.reviews.isEmpty)
            }else{
                error!()
            }
        }
    }
}
