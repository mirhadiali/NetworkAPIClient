//
//  Models.swift
//  ApiClient
//
//  Created by Hadi on 02/10/2021.
//

import Foundation
struct Users : Decodable {
    let data : User?
    let message : String?
    let status : Bool?
    let statusCode : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
        case statusCode = "statusCode"
    }
}
struct User : Codable {
    
    let avatar : String?
    let createdAt : String?
    let id : Int?
    let knownIps : String?
    let name : String?
    let profile : Bool?
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

/*
 https://mocki.io/v1/68d121fd-7f2b-4613-9b3d-184618a074f6
 {
   "status": false,
   "data": {
     "avatar": "Hello",
     "createdAt": "bearer",
     "id": 1638124432221,
     "knownIps": "Saturday, November 27, 2021",
     "name": "Hadi Ali",
     "profile": true,
     "username": "Hadi"
   },
   "statusCode": 1500,
   "message": "Success"
 }
 */
