//
//  Models.swift
//  ApiClient
//
//  Created by Hadi on 02/10/2021.
//

import Foundation
struct Users : Decodable {
    let users: [User]?
    
    enum CodingKeys: String, CodingKey {
        case users = "data"
    }
}
struct User : Decodable {
    
    let avatar : String?
    let createdAt : String?
    let id : String?
    let knownIps : [String]?
    let name : String?
    let profile : Profile?
    let username : String?
    
    enum CodingKeys: String, CodingKey {
        case avatar = "avatar"
        case createdAt = "createdAt"
        case id = "id"
        case knownIps = "knownIps"
        case name = "name"
        case profile = "profile"
        case username = "username"
    }
    
}

struct Profile : Decodable {
    
    let firstName : String?
    let lastName : String?
    let staticData : [Int]?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "firstName"
        case lastName = "lastName"
        case staticData = "staticData"
    }
    
}

// MARK: - Request models
struct UserRequestModel: Encodable {
    var name: String?
    
    init(name: String) {
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}
