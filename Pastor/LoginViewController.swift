//
//  LoginViewController.swift
//  Pastor
//
//  Created by Rémi Caroff on 24/08/2017.
//  Copyright © 2017 Rémi Caroff. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var validateButton: UIButton!
    @IBOutlet var signupButton: UIButton!
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Pastor"

        self.setupInput()
        self.setupOutput()
    }
    
    
    func setupInput() {
        
        self.emailTF.rx.text
            .orEmpty
            .bind(to: self.viewModel.emailInputText)
            .disposed(by:disposeBag)
        
        self.passwordTF.rx.text
            .orEmpty
            .bind(to: self.viewModel.passwordInputText)
            .disposed(by:disposeBag)
        
        self.validateButton.rx.tap.bind {
            self.viewModel.validateButtonTapped()
        }
        .disposed(by: disposeBag)
        
        self.signupButton.rx.tap.bind {
            self.showSignup()
        }
        .disposed(by: disposeBag)
        
    }
    
    func setupOutput() {
        self.viewModel.authValidated
        .subscribe(onNext: { isValid in
            if !isValid { return }
            self.showMain()
        })
        .disposed(by: disposeBag)
    }
    
    func showMain() {
        guard let appD = UIApplication.shared.delegate as? AppDelegate else { return }
        appD.loadMain()
    }
    
    func showSignup() {
        self.performSegue(withIdentifier: "showSubscribe", sender: nil)
    }
   
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSubscribe" {
            let destVC = segue.destination as! SubscribeViewController
            destVC.viewModel = SubscribeViewModel(with: SubscribeRepository())
        }
    }
    

}
