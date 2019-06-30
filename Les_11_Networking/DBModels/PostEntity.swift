//
//  PostEntity.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/30/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import Foundation
import CoreData

class PostEntity: NSManagedObject {
    
    class func findOrCreate(post: Post, context: NSManagedObjectContext) throws -> PostEntity {
        
        let request: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", post.id!)
        
        do {
            let posts = try context.fetch(request)
            if !posts.isEmpty {     // posts.count > 0
                assert(posts.count == 1, "There are few posts related to one identifier")
            }
        } catch {
            throw error
        }
        
        let postEntity = PostEntity(context: context)
        postEntity.title = post.title
        postEntity.body = post.body
        postEntity.id = Int64(post.id!)
        postEntity.userOwner = try? UserEntity.find(id: post.userId!, context: context)
        
        return postEntity
    }
}
