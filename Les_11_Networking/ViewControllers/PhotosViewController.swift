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
    
    var imagesUrls = [
        "https://cdn.pixabay.com/photo/2016/06/07/20/20/water-lily-1442497_1280.jpg",
        "https://cdn.pixabay.com/photo/2014/12/17/21/30/wild-flowers-571940_1280.jpg", "https://cdn.pixabay.com/photo/2016/08/14/12/41/water-lily-1592793_1280.png",
        "https://picsum.photos/id/239/1200/768",
        "https://picsum.photos/id/253/1200/768",
        "https://picsum.photos/id/215/1200/768",
        "https://picsum.photos/id/258/1200/768",
        "https://picsum.photos/id/238/1200/768",
        "https://picsum.photos/id/231/1200/768",
        "https://picsum.photos/id/230/1200/768"
    ]
    
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
//        return imagesUrls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = photosTableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCellID", for: indexPath) as! PhotosTableViewCell

        cell.imagePath = photos[indexPath.row].url
        cell.photosLabel.text = photos[indexPath.row].url
        cell.photosLabel.numberOfLines = 0
        
        //        cell.imagePath = imagesUrls[indexPath.row]
        //        cell.photosView.image = UIImage(named: "image_1")
        return cell
    }
    
}
