//
//  PhotosViewController.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/15/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet weak var photosTableView: UITableView!
    
    private var photos: [Photos] = [] {
        didSet {
            photosTableView.reloadData()
        }
    }
    
    public var photosId: Int?
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        photosTableView.delegate = self
        photosTableView.dataSource = self
    }
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        RequestManager.getPhotos(with: photosId ?? 0) { (getPhotos) in
            DispatchQueue.main.async {
                self.photos = getPhotos
            }
        }
    }
}

extension PhotosViewController: UITableViewDelegate,
UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = photosTableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCellID", for: indexPath) as! PhotosTableViewCell
        
        cell.imagePath = photos[indexPath.row].url
        cell.photosLabel.text = photos[indexPath.row].url
        cell.photosLabel.numberOfLines = 0
        
        return cell
    }
    
}
