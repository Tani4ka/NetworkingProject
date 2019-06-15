//
//  PhotosTableViewCell.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/15/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photosView: UIImageView!
    @IBOutlet weak var photosLabel: UILabel!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    var imagePath: String? {
        didSet {
            activityView.startAnimating()
            photosView.image = nil
            if let path = imagePath {
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageModel = ImageModel(imagePath: path)
                    
                    if path == self.imagePath {
                        DispatchQueue.main.async {
                            self.photosView.image = imageModel.image
                            self.activityView.stopAnimating()
                        }
                    } else {
                        print("path == self.image")
                    }
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
