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
    
    private var comments: [Comment] = [] {
        didSet {
            commentsTableView.reloadData()
        }
    }
    
    public var postID: Int?    
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        RequestManager.getComments(with: postID ?? 0) { (getComments) in
            DispatchQueue.main.async {
                self.comments = getComments
            }
        }
    }

}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = commentsTableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCellID", for: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = comments[indexPath.row].name
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        cell.detailTextLabel?.text = comments[indexPath.row].body
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }    
    
}
