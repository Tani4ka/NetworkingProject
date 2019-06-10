 //
//  RequestManager.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/5/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import Foundation
 
 class RequestManager {
    
    // getPosts
    class func getPosts(with userId: Int = 1, completionHandler: @escaping ([Post]) -> Void) {
        
        let path = "http://jsonplaceholder.typicode.com/posts"
        
        guard let url = URL(string: path) else { return }
        
        // работа с query параметрами http://jsonplaceholder.typicode.com/posts/.....
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "userId", value: String(userId))]
        
        // заменяем if на guard, так ка у нас нету else, так логичнее, другой программист не будет искать else после if
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
//                    print(string)
                    let posts = try JSONDecoder().decode([Post].self, from: jsonData)
//                    print(posts)
                    completionHandler(posts)
                } catch {
                    print(error.localizedDescription)
                }
                // .decode() throws - можно использовать try? вместо do catch, но он вернет [Posts]? или nill
                //                    let data = try? JSONDecoder().decode([Post].self, from: jsonData)
            }
        }
        dataTask.resume()
    }
    
    // users
    class func getUsers(completionHandler: @escaping ([User]) -> Void) {
        
        let path = "http://jsonplaceholder.typicode.com/users"
        
        guard let url = URL(string: path) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let unwrapError = error {
                print("Error - \(unwrapError.localizedDescription)")
            } else if let jsonData = data ,
                let getResponse = response as? HTTPURLResponse,
                getResponse.statusCode == 200 {
                print("Data: \(jsonData)")
                
                do {
                    let users = try JSONDecoder().decode([User].self, from: jsonData)
                    completionHandler(users)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
    
    // createPost
    class func createPost(_ post: Post) {
        
        guard let url = URL(string: Constants.Networking.postsURL) else { return }
        
        guard let data = try? JSONEncoder().encode(post) else { return }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("\(data.count)", forHTTPHeaderField: "Content-Lenth")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // task загрузит данные на сервер, сделает POST
        // .uploadTask - чтобы загрузить файл или картинку
        // .dataTask - чтобы отправить json с POST
        let task = URLSession.shared.uploadTask(with: request as URLRequest, from: data)
        
        // чтобы проверить в коде ответ метода POST
//        request.httpBody = data
//        let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
//            // error? response?
//        }

        task.resume()
    }
    
 }
