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
    }

    func fetchData(){
        vm.fetchNowPlaying()
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.vm.movieList.value.count - 2{
            self.vm.fetchNextNowPlaying()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 20) / 2
        return CGSize(width: cellWidth, height: cellWidth * 3 / 2)
    }
}
