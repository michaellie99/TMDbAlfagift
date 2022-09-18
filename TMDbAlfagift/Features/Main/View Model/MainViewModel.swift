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
    
    func fetchNowPlaying(error: (()->Void)?){
        TheNetworkManager.fetchNowPlaying(page: 1) { data in
            if let data = data {
                self.updatePageData(data)
            }else{
                error!()
            }
        }
    }
    func fetchNextNowPlaying(error: (()->Void)?){
        guard currentPage < totalPages else {return}
        TheNetworkManager.fetchNowPlaying(page: currentPage+1) { data in
            if let data = data {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.updatePageData(data)
                }
            }else{
                error!()
            }
        }
    }
    private func updatePageData(_ response: GetNowPlayingResponse){
        var array: [MovieInfo] = movieList.value
        array.append(contentsOf: response.results)
        movieList.accept(array)
        currentPage = response.page
        totalPages = response.totalPages
    }
    
}
