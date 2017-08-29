//
//  SubscribeViewModel.swift
//  Pastor
//
//  Created by Rémi Caroff on 25/08/2017.
//  Copyright © 2017 Rémi Caroff. All rights reserved.
//

import UIKit
import RxSwift
import FirebaseAuth

protocol SubscribeViewModelInput {
    var nameInputText: Variable<String> { get set }
    var emailInputText: Variable<String> { get set }
    var passwordInputText: Variable<String> { get set }
    
    func validateButtonTapped()
}

protocol SubscribeViewModelOutput {
    var subscriptionValidated: PublishSubject<Bool> { get set }
}

class SubscribeViewModel: NSObject, SubscribeViewModelInput, SubscribeViewModelOutput {
    
    // input
    var passwordInputText: Variable<String> = Variable("")
    var emailInputText: Variable<String> = Variable("")
    var nameInputText: Variable<String> = Variable("")

    // output
    var subscriptionValidated: PublishSubject<Bool> = PublishSubject()

    let disposeBag = DisposeBag()
    private var repository: SubscribeRepository
    
    
    init(with repository: SubscribeRepository) {
        self.repository = repository
        
        super.init()
        self.setupInputActions()
    }
    
    func setupInputActions() {
        
    }
    
    func validateButtonTapped() {
        
        self.repository.subscribe(name: self.nameInputText.value, email: self.emailInputText.value, password: self.passwordInputText.value) { user in
            self.subscriptionValidated.onNext(user != nil)
        }
        
    }
    
    

}
