//
//  CommentsViewController.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/11/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {

    @IBOutlet weak var commentsTableView: UITableView!

//    private var comments: [Comment] = [] {
//        didSet {
//            commentsTableView.reloadData()
//        }
//    }
    private var comments: [Comment] = []

    public var postIdentifier: Int?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initCommentsModels()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        RequestManager.getComments(with: postId ?? 0) { (getComments) in
//            DispatchQueue.main.async {
//                self.comments = getComments
//            }
//        }
//    }

    func initCommentsModels() {
        DataManager().getComments(with: postIdentifier ?? 0, { (getComments) in
            self.comments = getComments
            DispatchQueue.main.async {
                self.commentsTableView.reloadData()
            }
        })
    }
}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = commentsTableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCellID",
                for: indexPath) as! CommentsTableViewCell  // swiftlint:disable:this force_cast

//        if let id = comments[indexPath.row].id {
//            cell.idLabel.text = String("id:  \(id)")
//        }

        cell.postIdLabel.text = String(comments[indexPath.row].postId)
        cell.idLabel.text = String(comments[indexPath.row].id)
        cell.nameLabel.text = comments[indexPath.row].name
        cell.emailLabel.text = comments[indexPath.row].email
//        cell.bodyLabel.text = "body: \(comments[indexPath.row].body ?? "")"
        cell.bodyLabel.text = comments[indexPath.row].body

//        // if subtitle style in table, not custom
//        cell.textLabel?.text = comments[indexPath.row].name
//        cell.textLabel?.numberOfLines = 0
//        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
//        cell.detailTextLabel?.text = comments[indexPath.row].body
//        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
}
