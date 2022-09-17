//
//  MovieDetailViewController.swift
//  TMDbAlfagift
//
//  Created by Michael Lie on 17/09/22.
//

import UIKit
import RxSwift
import RxCocoa
import youtube_ios_player_helper

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var youtubePlayer: YTPlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var vm = MovieDetailViewModel()
    private let cellId = "ReviewTableViewCell"
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setRx()
        getDetail()
    }

    func setUI(){
        youtubePlayer.delegate = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        vm.getVideos {
            DispatchQueue.main.async {
                self.youtubePlayer.load(withVideoId: self.vm.videoId)
            }
        }
    }
    func setRx(){
        vm.reviewList.bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: ReviewTableViewCell.self)){index, data, cell in
            cell.setCell(data)
        }.disposed(by: disposeBag)
        vm.title.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
        vm.overview.bind(to: descLabel.rx.text).disposed(by: disposeBag)
    }
    func getDetail(){
        vm.getMovieDetail()
        vm.getReviews()
    }
}

extension MovieDetailViewController: YTPlayerViewDelegate{
    
}
