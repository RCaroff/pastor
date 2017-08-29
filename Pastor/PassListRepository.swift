//
//  PassListRepository.swift
//  Pastor
//
//  Created by Rémi Caroff on 10/07/2017.
//  Copyright © 2017 Rémi Caroff. All rights reserved.
//

import UIKit
import RxSwift

class PassListRepository: NSObject {
    
    override init() {
        super.init()
    }
    
    func getPassList() -> Observable<[Pass]> {
        let pass = Pass(name: "Amazon", password: "dknfl6ldm")
        
        return Observable.just([pass])
        
    }

}
