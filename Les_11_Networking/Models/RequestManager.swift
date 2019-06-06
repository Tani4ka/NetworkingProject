 //
//  RequestManager.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/5/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import Foundation
 
 class RequestManager {
    
    class func getPosts(with userId: Int = 1) {
        
        let path = "http://jsonplaceholder.typicode.com/posts"
        
        guard let url = URL(string: path) else { return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "userId", value: String(userId))]
        
        guard let urlWithQuery = components?.url else { return }
        
        let dataTask = URLSession.shared.dataTask(with: urlWithQuery) { (data, response, error) in
            
            if let unwrapError = error {
                print("Error - \(unwrapError.localizedDescription)")
            } else if let jsonData = data ,
                let getResponse = response as? HTTPURLResponse,
                getResponse.statusCode == 200 {
                print("Data: \(jsonData)")
                
                // если в do try будет ошибка то код перепрыгнет в catch не выполняя следующие строки
                do {
                    // для проверки переводим данные в строку и смотрим правильный ли формат
                    let string = String(data: jsonData, encoding: String.Encoding.utf8)
                    
                    let posts = try JSONDecoder().decode([Post].self, from: jsonData)
                    print(posts)
//                    print(string)
                } catch {
                    print(error.localizedDescription)
                }
                
                // .decode() throws - можно использовать try? вместо do catch, но он вернет [Posts]? или nill
                //                    let data = try? JSONDecoder().decode([Post].self, from: jsonData)
                
            }
        }
        dataTask.resume()
    }
    
 }
