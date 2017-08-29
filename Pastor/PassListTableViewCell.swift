//
//  PassListTableViewCell.swift
//  Pastor
//
//  Created by Rémi Caroff on 10/07/2017.
//  Copyright © 2017 Rémi Caroff. All rights reserved.
//

import UIKit

class PassListTableViewCell: UITableViewCell {
    
    @IBOutlet var serviceNameLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContentWith(pass: PassVM) {
        self.serviceNameLabel.text = pass.serviceName
        self.passwordLabel.text = pass.password
    }

}
