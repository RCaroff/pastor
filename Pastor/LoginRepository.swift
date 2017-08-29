//
//  LoginRepository.swift
//  Pastor
//
//  Created by Rémi Caroff on 24/08/2017.
//  Copyright © 2017 Rémi Caroff. All rights reserved.
//

import UIKit
import RxSwift
import Firebase

class LoginRepository: NSObject {

    override init() {
        super.init()
    }
    
    func authUser(email: String, password: String, completion: @escaping (User?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            
            completion(user)
        }
        
    }
    
}
