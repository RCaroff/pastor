//
//  SubscribeRepository.swift
//  Pastor
//
//  Created by Rémi Caroff on 25/08/2017.
//  Copyright © 2017 Rémi Caroff. All rights reserved.
//

import UIKit
import RxSwift
import FirebaseAuth

class SubscribeRepository: NSObject {
    

    func subscribe(name: String, email: String, password: String, completion: @escaping (User?)->Void) {
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            
            completion(user)
        })

    }

}
