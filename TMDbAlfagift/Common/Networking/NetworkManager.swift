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
    
    func fetchNowPlaying(page: Int, completionHandler: @escaping (GetNowPlayingResponse?) -> Void) {
        if let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=\(page)&region=ID") {
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
                        let decoded = try decoder.decode(GetNowPlayingResponse.self, from: jsonData)
                        completionHandler(decoded)
                    } catch {
                        print("JSON error: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
    }
    func getVideos(id: Int, completionHandler: @escaping (GetVideoResponse?) -> Void) {
        if let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=\(apiKey)&language=en-US") {
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
                        let decoded = try decoder.decode(GetVideoResponse.self, from: jsonData)
                        completionHandler(decoded)
                    } catch {
                        print("JSON error: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
    }
    
    func getMovieDetail(id: Int, completionHandler: @escaping (MovieDetail?) -> Void) {
        if let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)") {
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
                        let decoded = try decoder.decode(MovieDetail.self, from: jsonData)
                        completionHandler(decoded)
                    } catch {
                        print("JSON error: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
    }
    
    func getReviews(id: Int, completionHandler: @escaping (GetReviewsResponse?) -> Void) {
        if let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/reviews?api_key=\(apiKey)") {
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
                        let decoded = try decoder.decode(GetReviewsResponse.self, from: jsonData)
                        completionHandler(decoded)
                    } catch {
                        print("JSON error: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
    }
}
