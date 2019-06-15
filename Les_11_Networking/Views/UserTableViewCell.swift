//
//  UserTableViewCell.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/11/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit

protocol UserTableViewCellDelegate: class {
    func postsDidTap()
    func albumsDidTap()
}

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    weak var delegate: UserTableViewCellDelegate?
    
    @IBAction func postsAction(_ sender: Any) {
        delegate?.postsDidTap()
//        print("postsDidTap in cell")
        
    }
    
    @IBAction func albumsAction(_ sender: Any) {
        delegate?.albumsDidTap()
//        print("albumsDidTap in cell")
    }
}
