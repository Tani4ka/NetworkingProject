//
//  DBModels.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/28/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import Foundation
import CoreData

class UserEntity: NSManagedObject {
    
    // find()
    class func find(id: Int, context: NSManagedObjectContext) throws -> UserEntity {
        
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let users = try context.fetch(request)
            assert(users.count == 1, "There are few users related to one identifier")
            return users[0]
        } catch {
            throw error
        }
    }

    // findOrCreate()
    class func findOrCreate(user: User, context: NSManagedObjectContext) throws -> UserEntity {
        // Сначала ищем элемент в базе, если нету создаем и записываем, чтобы избежать дублирования
        // throws - функция при вызове если что вернет ошибку, нужно будет указывать try в doCatch
        
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", user.id!)
        // "name in %@", ["Tanya", "Vasya", "Sasha"] - найдет имя или Tanya или Vasya или Sasha
        // "id == %d && name == %@", user.id!, user.name!  // "id in %@", [4,5,6]"
        
        do {
            let users = try context.fetch(request)
            if !users.isEmpty {
                // assert - функция для debug разработки, в relise не попадает, работает только в debug
                assert(users.count == 1, "There are few users related to one identifier")
                // если больше одного крешнится
                return users[0] // если нашли одного - возвращаем
            }
        } catch {
            throw error // throw error - завершает выполнение функции и выводит ошибку
        }
        
        let userEntity = UserEntity(context: context)
        userEntity.email = user.email
        userEntity.id = Int64(user.id!)
        userEntity.name = user.name
        userEntity.userName = user.username
        
        return userEntity
    }
}
