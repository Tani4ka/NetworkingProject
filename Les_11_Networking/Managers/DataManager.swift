//
//  DataManager.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/30/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import Foundation
import CoreData

// Правильно разделять классы для работы с базой и UI, и конвертировать эти модели между собой,
// чтобы обезопасить UI от модели напрямую работающей с базой данных
// класс для работы с базой
class DataManager {

    // getUsers() - запрашивает юзеров с базы или с сервера
    func getUsers(_ complitionHandler: @escaping ([User]) -> Void) {

//        DispatchQueue.main.async {

            // запрашиваем данные из базы если они есть
            let userEntities = try? UserEntity.getAllUsers(context: AppDelegate.viewContext)

            // конвертируем эти данные в модели User-ов
            if let  users = userEntities,
                !users.isEmpty {   // users.count > 0
                var returnedUsersArray: [User] = []

                for userEntity in users {
                    // в User нужно создать инициализатор с UserEntity и там все это конвертировать,
                    // тогда сдесь мы просто вызовем инициализатор let user = User(...) и все
                    let user = User(userEntity: userEntity)
//                    user.id = Int(userEntity.id)
//                    user.name = userEntity.name
//                    user.username = userEntity.userName
//                    user.email = userEntity.email

                    returnedUsersArray.append(user)
                }
                // возвращаем модели User-ов вне
                complitionHandler(returnedUsersArray)
            } else { // если данных в базе нету, то мы делаем запрос на сервер

                // RequestManager.getUsers(completionHandler: completionHandleer) // в этом случае
                // ф-цию getUsers будет обрабатывать ф-ция выше getUsers и данные не сохраняться в базу

                // сервер возвращает нам юзеров
                RequestManager.getUsers { (users) in
                    // выносим на background context, так как с срвера загружаеться с задержкой.
                    DispatchQueue.main.async {
                        AppDelegate.dbPersistentContainer.performBackgroundTask({ (context) in
                            // проходим по всем юзерам и сохраняем их в базу
                            for user in users {
                                _ = try? UserEntity.findOrCreate(user: user, context: context)
                            }
                            try? context.save() // сохраняем саму базу
                            complitionHandler(users) // возвращаем тому, кто нас вызвал массив юзеров
                        })
                    }
                }
            }
//        }
    }

    // getPosts()
    func getPosts(with userId: Int, _ complitionHandler: @escaping ([Post]) -> Void) {

        let postEntities = try? PostEntity.find(userId: userId, context: AppDelegate.viewContext)

        if let posts = postEntities,
            !posts.isEmpty {

            var returnedPostsArray: [Post] = []

            for postEntity in posts {
                let post = Post()
                post.id = Int(postEntity.id)
                post.title = postEntity.title
                post.body = postEntity.body
//                print(post.id!)

                returnedPostsArray.append(post)
            }
//            returnedPostsArray.sorted(by: { (post1: Post, post2: Post) -> Bool in
//                return (post1.id ?? 0) > (post2.id ?? 0)
//            })
            complitionHandler(returnedPostsArray)
        } else {
            RequestManager.getPosts(with: userId, completionHandler: { (posts) in
                DispatchQueue.main.async {
                    AppDelegate.dbPersistentContainer.performBackgroundTask({ (context) in
                        for post in posts {
                            _ = try? PostEntity.findOrCreate(post: post, context: context)
                        }
                        try? context.save()
                        complitionHandler(posts)

                    })
                }
            })
        }
    }

    // get Comments()
    func getComments(with postId: Int, _ complitionHandler: @escaping ([Comment]) -> Void) {

        let commentsEntity = try? CommentsEntity.findComments(postId: postId,
                                                              context: AppDelegate.viewContext)
        if let comments = commentsEntity,
            !comments.isEmpty {

            var returnedCommentsArray: [Comment] = []

            for commentsEntity in comments {
                let comment = Comment(commentsEntity: commentsEntity)
//                 print("DataManager getComments: \(comment.id)")
                returnedCommentsArray.append(comment)
            }
            complitionHandler(returnedCommentsArray)
        } else {
            RequestManager.getComments(with: postId) { (comments) in
                DispatchQueue.main.async {
                    AppDelegate.dbPersistentContainer.performBackgroundTask({ (context) in
                        for comment in comments {
                            _ = try? CommentsEntity.findOrCreate(comment: comment, context: context)
                        }
                        try? context.save()
                        complitionHandler(comments)
                    })
                }
            }
        }
    }
}
