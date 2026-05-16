//
//  ProfileResponse.swift
//  Habit
//
//  Created by VITOR SHERMON on 13/05/26.
//
import Foundation
import SwiftUI
import Combine

struct ProfileResponse: Decodable {
    
    let id: Int
    let fullName: String
    let email: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "name"
        case email
        case document
        case phone
        case birthday
        case gender
    }
}

