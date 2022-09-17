//
//  MainViewModel.swift
//  TMDbAlfagift
//
//  Created by Michael Lie on 17/09/22.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel{
    
    var movieList = BehaviorRelay<[MovieInfo]>(value: [])
    var currentPage = 0
    var totalPages = 100
    
    func fetchNowPlaying(){
        TheNetworkManager.fetchNowPlaying(page: 1) { data in
            if let data = data {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.updatePageData(data)
                }
            }
        }
    }
    func fetchNextNowPlaying(){
        TheNetworkManager.fetchNowPlaying(page: currentPage+1) { data in
            if let data = data {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.updatePageData(data)
                }
            }
        }
    }
    func updatePageData(_ response: NowPlayingResponse){
        var array: [MovieInfo] = movieList.value
        array.append(contentsOf: response.results)
        movieList.accept(array)
        currentPage = response.page
        totalPages = response.totalPages
    }
    
}
