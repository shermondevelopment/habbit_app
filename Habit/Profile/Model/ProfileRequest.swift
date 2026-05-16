//
//  ProfileRequest.swift
//  Habit
//
//  Created by VITOR SHERMON on 14/05/26.
//
import Foundation

struct ProfileRequest: Encodable {
    
    let fullName: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case phone
        case birthday
        case gender
    }
}
