//
//  Pass.swift
//  Pastor
//
//  Created by Rémi Caroff on 10/07/2017.
//  Copyright © 2017 Rémi Caroff. All rights reserved.
//

import UIKit
import RxDataSources

class Pass: NSObject {
    var passID: String
    var serviceName: String
    var servicePassword: String
    
    init(name: String, password: String) {
        self.passID = password
        self.serviceName = name
        self.servicePassword = password
    }
}

struct PassListSection {
    var header: String
    var items: [Item]
}


extension PassListSection: SectionModelType {
    typealias Item = Pass
    
    init(original: PassListSection, items: [Item]) {
        self = original
        self.items = items
    } 
}
