//
//  UserAuth.swift
//  Habit
//
//  Created by VITOR SHERMON on 03/05/26.
//

import Foundation

struct UserAuth: Codable {
    var idToken: String
    var refreshToken: String
    var expires: Double
    var tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case idToken = "access_token"
        case refreshToken = "refresh_token"
        case expires = "expires_in"
        case tokenType = "token_type"
    }
}
