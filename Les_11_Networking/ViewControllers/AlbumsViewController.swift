//
//  AlbumsViewController.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/14/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {

    @IBOutlet weak var albumsTableView: UITableView!

    private var albums: [Albums] = [] {
        didSet {
            albumsTableView.reloadData()
        }
    }

    public var user: User?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        albumsTableView.delegate = self
        albumsTableView.dataSource = self
    }

    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        RequestManager.getAlbums(with: user?.id ?? 0) { (getAlbums) in
            DispatchQueue.main.async {
//                print(getAlbums.count)
                self.albums = getAlbums
            }
        }
    }

}

extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return albums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = albumsTableView.dequeueReusableCell(withIdentifier: "AlbumsTableViewCellID",
                                                       for: indexPath)

//        let idInt = albums[indexPath.row].id
//        if let idStr = idInt {
//            cell.textLabel?.text = String(idStr)
//        }

        cell.textLabel?.text = albums[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17.0)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let photosVC = navigationController?.storyboard?.instantiateViewController(withIdentifier:
            "PhotosViewControllerID") as? PhotosViewController {

            photosVC.title = "Photos"
            photosVC.photosId = albums[indexPath.row].id

            navigationController?.pushViewController(photosVC, animated: true)
        }
    }
}
