//
//  LoginViewModel.swift
//  Pastor
//
//  Created by Rémi Caroff on 24/08/2017.
//  Copyright © 2017 Rémi Caroff. All rights reserved.
//
import UIKit
import RxSwift

protocol LoginViewModelInput {
    var emailInputText: Variable<String> { get set }
    var passwordInputText: Variable<String> { get set }
    
    func validateButtonTapped()
}

protocol LoginViewModelOutput {
    var authValidated: PublishSubject<Bool> { get set }
}

class LoginViewModel: NSObject, LoginViewModelInput, LoginViewModelOutput {
    
    var repository = LoginRepository()
    
    // input
    var emailInputText: Variable<String> = Variable("")
    var passwordInputText: Variable<String> = Variable("")

    
    // output
    var authValidated: PublishSubject<Bool> = PublishSubject()
    let disposeBag = DisposeBag()
    
    override init() {
        super.init()
    }
    
    func setupInputActions() {
        self.validateButtonTapped()
    }
    
    func validateButtonTapped() {
        self.repository.authUser(email: self.emailInputText.value, password: self.passwordInputText.value) { user in
            self.authValidated.onNext(user != nil)
        }
    }
}
