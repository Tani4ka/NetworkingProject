//
//  Users.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/5/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import Foundation

class User: Codable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: UserAddress?
    var phone: String?
    var website: String?
    var company: UserCompany?
    
    init(id: Int, name: String, username: String, email: String, address: UserAddress, phone: String,
         website: String, company: UserCompany) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }

    init(userEntity: UserEntity) {
        self.id = Int(userEntity.id)
        self.name = userEntity.name ?? ""
        self.username = userEntity.userName ?? ""
        self.email = userEntity.email ?? ""
    }
}

class UserAddress: Codable {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: UserGeo?
}

class UserGeo: Codable {
    var lat: String?
    var lng: String?
}

class UserCompany: Codable {
    var name: String?
    var catchPhrase: String?
    var bs: String?
}

class Comment: Codable {
    var postId: Int?
    var id: Int?
    var name: String?
    var email: String?
    var body: String?
}

class Albums: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
}

class Photos: Codable {
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
}
