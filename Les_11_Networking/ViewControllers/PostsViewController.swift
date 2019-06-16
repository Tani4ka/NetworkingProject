//
//  PostsViewController.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/11/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet weak var postsTableView: UITableView!
    
    private var posts: [Post] = [] {
        didSet {
            postsTableView.reloadData()
        }
    }
    
    public var user: User?
    
     // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
    }

     // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        RequestManager.getPosts(with: user?.id ?? 0) { (getPosts) in
            DispatchQueue.main.async {
//                print(getPosts.count)
                self.posts = getPosts
            }
        }
    }
}

extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = postsTableView.dequeueReusableCell(withIdentifier: "PostsViewControllerCellID", for: indexPath) as! PostsTableViewCell
        
        cell.postsLabel.text = posts[indexPath.row].title
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let commentsVC = navigationController?.storyboard?.instantiateViewController(withIdentifier: "commentsViewControllerID") as? CommentsViewController {
            
            commentsVC.title = "Comments View Controller"
            commentsVC.postID =  posts[indexPath.row].id
            
            navigationController?.pushViewController(commentsVC, animated: true)
        }
    }
    
}

