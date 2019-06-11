//
//  Users.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/5/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import Foundation

class User: Codable {
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var address: UserAddress?
    var phone: String?
    var website: String?
    var company: UserCompany?
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
