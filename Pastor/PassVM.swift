//
//  PassVM.swift
//  Pastor
//
//  Created by Rémi Caroff on 11/07/2017.
//  Copyright © 2017 Rémi Caroff. All rights reserved.
//

import UIKit

class PassVM: NSObject {
    var serviceName: String
    var password: String
    
    init(with pass: Pass) {
        self.serviceName = pass.serviceName
        self.password = pass.servicePassword
    }
}
