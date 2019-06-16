 //
//  RequestManager.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/5/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import Foundation
 
 class RequestManager {
    
    // createPost
    class func createPost(_ post: Post) {
        
        guard let url = URL(string: Constants.Networking.posts) else { return }
        
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

    // getUsers
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
                    let getUsers = try JSONDecoder().decode([User].self, from: jsonData)
                    completionHandler(getUsers)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
    
    // getComments
    class func getComments(with postID: Int, completionHandler: @escaping ([Comment]) -> Void) {
        
        guard let url = URL(string: Constants.Networking.comments) else { return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "postId", value: String(postID))]
        
        // заменяем if на guard, так ка у нас нету else, так логичнее, другой программист не будет искать else после if
        guard let urlWithQuery = components?.url else { return }
        
        let dataTask = URLSession.shared.dataTask(with: urlWithQuery) { (data, response, error) in
            
            if let unwrapError = error {
                print("Error - \(unwrapError.localizedDescription)")
            } else if let jsonData = data ,
                let getResponse = response as? HTTPURLResponse,
                getResponse.statusCode == 200 {
                print("Data: \(jsonData)")
                
                do {
                    let comments = try JSONDecoder().decode([Comment].self, from: jsonData)
                    completionHandler(comments)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
    
    // getPosts
    class func getPosts(with userId: Int = 1, completionHandler: @escaping ([Post]) -> Void) {
        
        guard let url = URL(string: Constants.Networking.posts) else { return }
        
        // работа с query параметрами
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
                    _ = String(data: jsonData, encoding: String.Encoding.utf8)
                    //                    print(string)
                    let getPosts = try JSONDecoder().decode([Post].self, from: jsonData)
                    //                    print(posts)
                    completionHandler(getPosts)
                } catch {
                    print(error.localizedDescription)
                }
                // .decode() throws - можно использовать try? вместо do catch, но он вернет [Posts]? или nill
                //                    let data = try? JSONDecoder().decode([Post].self, from: jsonData)
            }
        }
        dataTask.resume()
    }
    
    // getAlbums
    class func getAlbums(with userId: Int = 1, completionHandler: @escaping ([Albums]) -> Void) {
        
        guard let url = URL(string: Constants.Networking.albums) else { return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "userId", value: String(userId))]
        
        // заменяем if на guard, так ка у нас нету else, так логичнее, другой программист не будет искать else после if
        guard let urlWithQuery = components?.url else { return }
        
        let dataTask = URLSession.shared.dataTask(with: urlWithQuery) { (data, response, error) in
            
            if let unwrapError = error {
                print("Error - \(unwrapError.localizedDescription)")
            } else if let jsonData = data,
                let getResponse = response as? HTTPURLResponse,
                getResponse.statusCode == 200 {
                print("Data: \(jsonData)")
                
                do {
                    let albums = try JSONDecoder().decode([Albums].self, from: jsonData)
                    completionHandler(albums)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
    
    // getPhotos
    class func getPhotos(with albumId: Int, completionHandler: @ escaping ([Photos]) -> Void) {
        
        guard let url = URL(string: Constants.Networking.photos) else { return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "albumId", value: String(albumId))]
        
        // заменяем if на guard, так ка у нас нету else, так логичнее, другой программист не будет искать else после if
        guard let urlWithQuery = components?.url else { return }
        
        let dataTask = URLSession.shared.dataTask(with: urlWithQuery) { (data, response, error) in
            
            if let unwrapError = error {
                print("Error - \(unwrapError.localizedDescription)")
            } else if let jsonData = data,
                let getResponse = response as? HTTPURLResponse ,
                getResponse.statusCode == 200 {
                print("Data: \(jsonData)")
                
                do {
                    let photos = try JSONDecoder().decode([Photos].self, from: jsonData)
                    completionHandler(photos)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
 }
