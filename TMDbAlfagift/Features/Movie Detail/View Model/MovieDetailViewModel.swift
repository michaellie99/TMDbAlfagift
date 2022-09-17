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
    
    var reviewList = BehaviorRelay<[Review]>(value: [])
    let title = BehaviorRelay<String>(value: "")
    let overview = BehaviorRelay<String>(value: "")
    
    func getVideos(completion: @escaping ()->()){
        TheNetworkManager.getVideos(id: id) { [unowned self] data in
            if let data = data{
                if !data.videos.isEmpty{
                    self.videoId = data.videos[0].key
                    print(self.videoId)
                    completion()
                }
            }
        }
    }
    func getMovieDetail(){
        TheNetworkManager.getMovieDetail(id: id) { [unowned self] data in
            if let data = data{
                title.accept(data.originalTitle)
                overview.accept(data.overview)
            }
        }
    }
    func getReviews(){
        TheNetworkManager.getReviews(id: id) {  [unowned self] data in
            if let data = data{
                print(data.reviews.count)
                reviewList.accept(data.reviews)
            }
        }
    }
}
