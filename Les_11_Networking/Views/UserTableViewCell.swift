//
//  UserTableViewCell.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/11/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureUsersCell(_ user: User) {
        userNameLabel.text = user.name
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
