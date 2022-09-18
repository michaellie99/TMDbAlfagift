//
//  MovieDetailViewController.swift
//  TMDbAlfagift
//
//  Created by Michael Lie on 17/09/22.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import youtube_ios_player_helper

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var youtubePlayer: YTPlayerView!
    @IBOutlet weak var youtubeLoadingIndicatorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noReviewView: UIView!
    
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
        noReviewView.layer.cornerRadius = 16
    }
    func setRx(){
        vm.reviewList.bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: ReviewTableViewCell.self)){index, data, cell in
            cell.setCell(data)
        }.disposed(by: disposeBag)
        vm.title.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
        vm.overview.bind(to: descLabel.rx.text).disposed(by: disposeBag)
        vm.isReviewHidden.bind(to: noReviewView.rx.isHidden).disposed(by: disposeBag)
        backButton.rx.tap.bind { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
        tableView.rx.modelSelected(Review.self).bind{ [weak self] review in
            let vc = ReviewDetailViewController()
            vc.vm = ReviewDetailViewModel(review)
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self?.present(vc, animated: true)
        }.disposed(by: disposeBag)
        tableView.rx.itemSelected.bind{ [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            let review = self?.vm.reviewList.value[indexPath.row]
            let vc = ReviewDetailViewController()
            vc.vm = ReviewDetailViewModel(review!)
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self?.present(vc, animated: true)
        }.disposed(by: disposeBag)
    }
    func getDetail(){
        vm.getMovieDetail{ [weak self] in
            self?.showError("Fetch Movie Detail Error")
        }
        vm.getReviews{ [weak self] in
            self?.showError("Fetch Reviews Error")
        }
    }
}

extension MovieDetailViewController: YTPlayerViewDelegate{
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.youtubeLoadingIndicatorView.isHidden = true
    }
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        self.showError("Error Loading Youtube Video")
    }
    
}
