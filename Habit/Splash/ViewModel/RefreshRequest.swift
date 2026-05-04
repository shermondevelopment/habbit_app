//
//  RefreshRequest.swift
//  Habit
//
//  Created by VITOR SHERMON on 03/05/26.
//

import Foundation

struct RefreshRequest: Codable {
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}
