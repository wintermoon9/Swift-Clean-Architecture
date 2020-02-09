//
//  SearchViewController.swift
//  feature
//
//  Created by Daniel Christopher on 2/9/20.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

public class SearchViewController: UIViewController {
    
    private var model: SearchViewModel
    
    // MARK: events
    private let _searchUsers = PublishSubject<String>()
    
    init (_ model: SearchViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

// MARK: setup

private extension SearchViewController {
    
    func setUp() {
        bindToViewModel()
    }
    
    func bindToViewModel() {
        let input = SearchViewModel.Input(searchUsers: _searchUsers.asDriver(onErrorJustReturn: ""))
        
        let output = model.transform(input: input)
        output.users.drive(onNext: { [weak self] res in
            guard let `self` = self else {
                return
            }
            
            switch res {
            case let .success(users):
                print("USERS: \(users)")
                break
            case let .error(code):
                print("ERROR: \(code)")
            case .loading:
                break
            }
        }).disposed(by: rxDisposeBag)
        
        _searchUsers.onNext("Maruthi Basava")
    }
}

// MARK: factory

public extension SearchViewController {
    
    static func create() -> SearchViewController {
        return UIApplication.plankDelegate().assembler.resolver.resolve(SearchViewController.self)!
    }
}
