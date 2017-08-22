//
//  ViewController.swift
//  Rx
//
//  Created by Pavlo Muratov on 09.08.17.
//  Copyright © 2017 MPO. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import Moya_ModelMapper

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    var latestRepositoryName: Observable<String> {
        return searchBar
            .rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupRx()
    }
    
    func setupRx() {
        tableView
            .rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.view.endEditing(true)
            })
            .addDisposableTo(disposeBag)
    }
    
}

