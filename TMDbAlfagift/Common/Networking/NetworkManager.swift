//
//  NetworkManager.swift
//  TMDbAlfagift
//
//  Created by Michael Lie on 17/09/22.
//

import Foundation

import Foundation

let TheNetworkManager = NetworkManager.sharedInstance

public class NetworkManager {
    
    class var sharedInstance: NetworkManager {
        struct Static {
            static let instance: NetworkManager = NetworkManager()
        }
        return Static.instance
    }
    private let session: URLSession
    private let apiKey = "30673bf20bdaf9edbffa45b3bb90eff3"
    
    init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil

        session = URLSession.init(configuration: config)
    }
    
    func fetchNowPlaying(page: Int, completionHandler: @escaping (NowPlayingResponse?) -> Void) {
        if let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=\(page)") {
            let task = session.dataTask(with: url) { (data, response, error) in
                if let err = error {
                    print(err.localizedDescription)
                    completionHandler(nil)
                    return
                }
                if let jsonData = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let decodedNowPlayingModel = try decoder.decode(NowPlayingResponse.self, from: jsonData)
                        completionHandler(decodedNowPlayingModel)
                    } catch {
                        print("JSON error: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
    }
}
