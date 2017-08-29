//
//  SubscribeViewController.swift
//  Pastor
//
//  Created by Rémi Caroff on 25/08/2017.
//  Copyright © 2017 Rémi Caroff. All rights reserved.
//

import UIKit
import RxSwift

class SubscribeViewController: UIViewController {
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var validateButton: UIButton!
    
    let disposeBag = DisposeBag()
    var viewModel: SubscribeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupInput()
        self.setupOutput()
    }
    
    func setupInput() {
        self.nameTF.rx.text
            .orEmpty
            .bind(to: self.viewModel.nameInputText)
            .disposed(by:disposeBag)
        
        self.emailTF.rx.text
            .orEmpty
            .bind(to: self.viewModel.emailInputText)
            .disposed(by:disposeBag)
        
        self.passwordTF.rx.text
            .orEmpty
            .bind(to: self.viewModel.passwordInputText)
            .disposed(by:disposeBag)
        
//        self.viewModel.nameInputText.asObservable().bind(to: self.nameTF.rx.text)
//        .disposed(by: disposeBag)
//        
//        self.viewModel.emailInputText.asObservable().bind(to: self.emailTF.rx.text)
//        .disposed(by: disposeBag)
//        
//        self.viewModel.passwordInputText.asObservable().bind(to: self.passwordTF.rx.text)
//        .disposed(by: disposeBag)
        
        self.validateButton.rx.tap.bind {
            self.viewModel.validateButtonTapped()
        }
        .disposed(by: disposeBag)
    }
    
    func setupOutput() {
        self.viewModel.subscriptionValidated
        .subscribe(onNext: { validated in
            if !validated {
                print("subscription failed")
                return
            }
            guard let appD = UIApplication.shared.delegate as? AppDelegate else { return }
            appD.loadMain()
        })
        .disposed(by: disposeBag)
    }

  

}
