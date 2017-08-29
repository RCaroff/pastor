//
//  PassViewModel.swift
//  Pastor
//
//  Created by Rémi Caroff on 10/07/2017.
//  Copyright © 2017 Rémi Caroff. All rights reserved.
//

import UIKit
import RxSwift

protocol PassListViewModelInput: NSObjectProtocol {
    var loadData:PublishSubject<Bool> { get set }
    var copyTapped:PublishSubject<String> { get set }
    var regenTapped: PublishSubject<Int> { get set }
}

protocol PassListViewModelOutput: NSObjectProtocol {
    var passCollection: PublishSubject<[PassListSection]> { get set }
}

class PassListViewModel: NSObject, PassListViewModelInput, PassListViewModelOutput {
    private var repository: PassListRepository
    private let disposeBag = DisposeBag()
    
    var passCollection: PublishSubject<[PassListSection]> = PublishSubject()
    var loadData: PublishSubject<Bool> = PublishSubject()
    var copyTapped: PublishSubject<String> = PublishSubject()
    var regenTapped: PublishSubject<Int> = PublishSubject()
    
    init(with repository: PassListRepository) {
        self.repository = repository
        super.init()
        
        self.setupInput()
    }
    
    func setupInput() {
        self.loadData.asObservable()
        .subscribe(onNext: { shouldLoad in
            self.loadDataSource()
        })
        .disposed(by: self.disposeBag)
        
        self.copyTapped.asObservable()
        .subscribe(onNext: { password in
            UIPasteboard.general.string = password
            print("copied to clipboard")
        })
        .disposed(by: disposeBag)
        
        self.regenTapped.asObservable()
        .subscribe(onNext: { passID in
            
        })
        .disposed(by: disposeBag)
    }
    

    
    private func loadDataSource() {
        self.repository.getPassList().asObservable()
            .map({ passList -> [PassListSection] in
                let passListSection = PassListSection(header: "", items: passList)
                return [passListSection]
            })
        .subscribe(passCollection)
        .disposed(by: self.disposeBag)
    }
}
