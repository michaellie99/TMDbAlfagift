//
//  ReviewDetailViewController.swift
//  TMDbAlfagift
//
//  Created by Michael Lie on 18/09/22.
//

import UIKit
import RxCocoa
import RxSwift

class ReviewDetailViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var vm: ReviewDetailViewModel?
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        setUI()
        setRx()
    }
    func setUI(){
        guard let vm = vm else{return}
        containerView.roundViewCorner(cornerRadius: 16, borderWidth: 1, borderColor: UIColor(red: 0.9137, green: 0, blue: 0.9294, alpha: 1.0))
        authorLabel.text = vm.author
        dateLabel.text = vm.author
        contentLabel.text = vm.content
    }
    func setRx(){
        dismissButton.rx.tap.bind{ [weak self] in
            self?.dismiss(animated: true)
        }.disposed(by: disposeBag)
    }
    

}
