//
//  ViewController.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/5/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func sendGetRequest(_ sender: Any) {
        RequestManager.getPosts(with: 1) { posts in
            print(posts)
            
            DispatchQueue.main.async {
                // update UI, так как этот clousure вызвался не на главной очереди
            }
        }
    }
    
    @IBAction func getUsrsersAction() {
        RequestManager.getUsers { (users) in
            print(users)
            
            DispatchQueue.main.async {
                // update UI
                 // update UI
            }
        }
    }
    
    @IBAction func createPostAction() {
        let post = Post()
        post.id = 321
        post.userId = 1
        post.body = "body title"
        post.title = "title string"
        
        RequestManager.createPost(post)
    }
    
}

