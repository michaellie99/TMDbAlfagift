//
//  MainViewController.swift
//  TMDbAlfagift
//
//  Created by Michael Lie on 16/09/22.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var toTopButtonView: UIView!
    @IBOutlet weak var toTopButton: UIButton!
    
    private let cellId = "MoviePosterCollectionViewCell"
    private var vm = MainViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setRx()
        fetchData()
    }
    
    func setUI(){
        toTopButtonView.layer.cornerRadius = 18
        collectionView.register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    func setRx(){
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        vm.movieList.bind(to: collectionView.rx.items(cellIdentifier: cellId, cellType: MoviePosterCollectionViewCell.self)){
            index, data, cell in
            cell.setCell(data)
        }.disposed(by: disposeBag)
        collectionView.rx.modelSelected(MovieInfo.self).bind { info in
            let vc = MovieDetailViewController()
            vc.vm.id = info.id
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
        toTopButton.rx.tap.bind { [weak self] in
            self?.collectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        }.disposed(by: disposeBag)
    }

    func fetchData(){
        vm.fetchNowPlaying { [weak self] in
            self?.showError("Fetch Now Playing Error")
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.vm.movieList.value.count - 2{
            self.vm.fetchNextNowPlaying { [weak self] in
                self?.showError("Fetch Error")
            }
        }
        if indexPath.row == 0 && !toTopButtonView.isHidden{
            UIView.animate(withDuration: 0.4) {
                self.toTopButtonView.isHidden = true
                self.toTopButtonView.alpha = 0
            }
        }
        if indexPath.row > 10 && toTopButtonView.isHidden{
            UIView.animate(withDuration: 0.4) {
                self.toTopButtonView.alpha = 0.75
                self.toTopButtonView.isHidden = false
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = width / 2
        return CGSize(width: cellWidth, height: cellWidth * 3 / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
