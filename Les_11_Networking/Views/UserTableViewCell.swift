//
//  UserTableViewCell.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/11/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit

protocol UserTableViewCellDelegate: class {
    func postsDidTap(indexPath: IndexPath?)
    func albumsDidTap(indexPath: IndexPath?)
}

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    var indexPath: IndexPath?
    weak var delegate: UserTableViewCellDelegate?
    
    @IBAction func postsAction(_ sender: Any) {
        delegate?.postsDidTap(indexPath: indexPath)
//        print("postsDidTap in cell")
        
    }
    
    @IBAction func albumsAction(_ sender: Any) {
        delegate?.albumsDidTap(indexPath: indexPath)
//        print("albumsDidTap in cell")
    }
}
