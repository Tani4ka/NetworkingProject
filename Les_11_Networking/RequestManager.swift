 //
//  RequestManager.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/5/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import Foundation
 
 class RequestManager {
    
    class func getPosts(with id: Int? = nil) {
        
        let path = "http://jsonplaceholder.typicode.com/posts"
        
        if let url = URL(string: path) {
            let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let unwrapError = error {
                    print("Error - \(unwrapError.localizedDescription)")
                } else if let getData = data ,
                    let getResponse = response as? HTTPURLResponse,
                getResponse.statusCode == 200 {
                    print("Data: \(getData)")
                }
            }
            dataTask.resume()
        }
    }
    
 }
