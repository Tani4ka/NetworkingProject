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

        guard let urll = URL(string: Constants.Networking.posts) else { return }

        guard let data = try? JSONEncoder().encode(post) else { return }

        let request = NSMutableURLRequest(url: urll)
        request.httpMethod = "POST"
        request.addValue("\(data.count)", forHTTPHeaderField: "Content-Lenth")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // task загрузит данные на сервер, сделает POST
        // .uploadTask - чтобы загрузить файл или картинку
        // .dataTask - чтобы отправить json с POST
        let task = URLSession.shared.uploadTask(with: request as URLRequest, from: data)

        // чтобы проверить в коде ответ метода POST
        //        request.httpBody = data
        //        let dataTask = URLSession.shared.dataTask(with: request as URLRequest)
        // { (data, response, error) in
        //            // error? response?
        //        }

        task.resume()
    }

    // getUsers
    class func getUsers(completionHandler: @escaping ([User]) -> Void) {

        let path = "http://jsonplaceholder.typicode.com/users"

        guard let urll = URL(string: path) else { return }

        let dataTask = URLSession.shared.dataTask(with: urll) { (data, response, error) in

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

        guard let urll = URL(string: Constants.Networking.comments) else { return }

        var components = URLComponents(url: urll, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "postId", value: String(postID))]

        // заменяем if на guard, так ка у нас нету else, так логичнее,
        // другой программист не будет искать else после if
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

        guard let urll = URL(string: Constants.Networking.posts) else { return }

        // работа с query параметрами
        var components = URLComponents(url: urll, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "userId", value: String(userId))]

        // заменяем if на guard, так ка у нас нету else, так логичнее,
        // другой программист не будет искать else после if
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

        guard let urll = URL(string: Constants.Networking.albums) else { return }

        var components = URLComponents(url: urll, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "userId", value: String(userId))]

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

        guard let urll = URL(string: Constants.Networking.photos) else { return }

        var components = URLComponents(url: urll, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "albumId", value: String(albumId))]

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

    //get
    class func getUrl(urll: URL) {

//        guard let urll = URL(string:"http://jsonplaceholder.typicode.com/posts/1") else { return }
        URLSession.shared.dataTask(with: urll) { (data, response, error) in
            guard error == nil else {
                print("error = \(String(describing: error?.localizedDescription))")
                return
            }

            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let json = data {
                guard let post = try? JSONDecoder().decode(Post.self, from: json) else { return }
                print("userID = \(post.userId!), title \(post.title!)")

//                Storage().saveInfoToCash(data: [json], key: STORAGEPOSTAPI)
            }
            }.resume()
    }

//    func post() {
//        let dict = ["userId": 1, "id":12341234, "title": "Twitter i ok", "body": "I think not"]
//            as [String: Any]
//        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
//
//            let urll = NSURL(string: "http://jsonplaceholder.typicode.com/posts")!
//            let request = NSMutableURLRequest(url: urll as URL)
//            request.httpMethod = "POST"
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpBody = jsonData
//
//            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
//                if error != nil {
//                    print(error?.localizedDescription as Any)
//                    return
//                }
//
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                        as? NSDictionary
//
//                    if let parseJSON = json {
//                        //let resultValue:String = parseJSON["success"] as! String;
//                        print("result: \(String(describing: response))")
//                        print(parseJSON)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                }
//            }
//            task.resume()
//        }
//    }

//    func download() {
//        let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory,
//                                                          in: .userDomainMask).first as URL?)!
//        let destinationFileUrl = documentsUrl.appendingPathComponent("downloadedFile.jpg")
//
//        let fileURL = URL(string: "https://www.w3schools.com/css/img_lights.jpg")
//
//        let sessionConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfig, delegate: self as? URLSessionDelegate,
//                                 delegateQueue: OperationQueue.main)
//
//        let request = URLRequest(url:fileURL!)
//
//        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
//            if let tempLocalUrl = tempLocalUrl, error == nil {
//                // Success
//                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
//                    print("Successfully downloaded. Status code: \(statusCode)")
//                }
//
//                do {
//                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
//                } catch (let writeError) {
//                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
//                }
//
//            } else {
//                print("Error took place while downloading a file. Error description: %@",
//                      error?.localizedDescription as Any)
//            }
//        }
//        task.resume()
//    }
 }
