//
//  SignUpRequest.swift
//  Habit
//
//  Created by VITOR SHERMON on 29/04/26.
//

struct SignUpRequest: Encodable {
    
    let fullName: String
    let email: String
    let password: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case email
        case password
        case document
        case phone
        case birthday
        case gender
    }
}

struct SignResponse: Encodable {
    
    
}
