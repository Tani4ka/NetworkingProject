//
//  ViewController.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/5/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //    private var users: [User] = [] {
//        didSet {
//            tableView.reloadData()
//        }
//    }
    private var users: [User] = []

     // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

//        activityIndicator.startAnimating()  // or in storyboard
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        initUserModels()
    }

     // MARK: - LifeCycle
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        RequestManager.getUsers { (getUsers) in
//
//            DispatchQueue.main.async {
//                self.users = getUsers
//            }
//        }
//    }

    func initUserModels() {
        DataManager().getUsers { (getUsers) in
            self.users = getUsers
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
//                self.activityIndicator.isHidden = true  // or in storyboard
            }
        }

//        RequestManager.getUsers { (getUsers) in
//            self.users = getUsers
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//                self.activityIndicator.stopAnimating()
//            }
//        }
    }
}

extension UsersViewController: UserTableViewCellDelegate, UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCellID", for: indexPath)
            as! UserTableViewCell // swiftlint:disable:this force_cast

        cell.userNameLabel.text = users[indexPath.row].name
        cell.userId.text = String(users[indexPath.row].id)
        cell.indexPath = indexPath
        cell.delegate = self

        return cell
    }

    func postsDidTap(indexPath: IndexPath?) {
        if let postsVC = navigationController?.storyboard?.instantiateViewController(withIdentifier:
            "postsViewControllerID") as? PostsViewController {

            postsVC.user = users[indexPath?.row ?? 0]
            postsVC.title = "Posts " + users[indexPath?.row ?? 0].name

            navigationController?.pushViewController(postsVC, animated: true)
        }
    }

    func albumsDidTap(indexPath: IndexPath?) {
        if let albumsVC = navigationController?.storyboard?.instantiateViewController(withIdentifier:
            "AlbumsViewControllerID") as? AlbumsViewController {

            albumsVC.user = users[indexPath?.row ?? 0]
            albumsVC.title = "Albums " + users[indexPath?.row ?? 0].name

            navigationController?.pushViewController(albumsVC, animated: true)
        }
    }
}

//    @IBAction func getUsrsersAction() {
//        RequestManager.getUsers { (users) in
//            print(users)
//
//            DispatchQueue.main.async {
//                // update UI, так как этот clousure вызвался не на главной очереди
//            }
//        }
//    }
//    @IBAction func sendGetRequest(_ sender: Any) {
//        RequestManager.getPosts(with: 1) { posts in
//            print(posts)
//
//            DispatchQueue.main.async {
//                // update UI, так как этот clousure вызвался не на главной очереди
//            }
//        }
//    }
//    @IBAction func createPostAction() {
//        let post = Post()
//        post.id = 321
//        post.userId = 1
//        post.body = "body title"
//        post.title = "title string"
//
//        RequestManager.createPost(post)
//        print("Send a POST post")
//    }
