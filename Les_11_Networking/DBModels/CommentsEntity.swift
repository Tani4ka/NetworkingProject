//
//  CommentsEntity.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 7/4/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import Foundation
import CoreData

class CommentsEntity: NSManagedObject {

    //getAllComments()
//    class func getAllComments(context: NSManagedObjectContext) throws -> [CommentsEntity] {
//
//        let request: NSFetchRequest<CommentsEntity> = CommentsEntity.fetchRequest()
//        do {
//            let comments = try context.fetch(request)
//            return comments
//        } catch {
//            throw error
//        }
//    }

    // findComments()
    class func findComments(postId: Int, context: NSManagedObjectContext) throws -> [CommentsEntity] {

        let postEntity = try? PostEntity.findPost(id: postId, context: context)

        guard let comments = postEntity?.comments as? Set<CommentsEntity> else {
            return []
        }
        let sortedComments = comments.sorted(by: {$0.id < $1.id})
        let commentsArray = Array(sortedComments)
        return commentsArray
    }

    // findOrCreate()
    class func findOrCreate(comment: Comment, context: NSManagedObjectContext) throws -> CommentsEntity {

        let request: NSFetchRequest<CommentsEntity> = CommentsEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", comment.id)

        do {
            let comments = try context.fetch(request)
            if !comments.isEmpty {
                assert(comments.count == 1, "There are few comments related to one identifier")
                return comments[0]
            }
        } catch {
            throw error
        }

        let commentsEntity = CommentsEntity(context: context)
        commentsEntity.postId = Int64(comment.postId)
        commentsEntity.id = Int64(comment.id)
        commentsEntity.name = comment.name
        commentsEntity.email = comment.email
        commentsEntity.body = comment.body
        // важно чтобы PostEntity и UserEntity были на одном контексте
        commentsEntity.postTheme = try? PostEntity.findPost(id: comment.postId, context: context)
        return commentsEntity
    }
}
