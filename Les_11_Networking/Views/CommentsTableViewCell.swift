//
//  CommentsTableViewCell.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 7/4/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var postIdLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
