//
//  Constants.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/10/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit

struct Constants {
    private init () {} // эту структуру нельзя создать и проиницилизировать
    
    struct Networking {
        private init () {}
        
        static let baseServerURL = "http://jsonplaceholder.typicode.com"
        static let posts = baseServerURL + "/posts"
        static let users = baseServerURL + "/users"
        static let comments = baseServerURL + "/comments"
    }
    
    struct UI {
        private init () {}
        
        static let rightOffsetCell: CGFloat = 10.0
    }
}
