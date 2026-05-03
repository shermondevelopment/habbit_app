//
//  ErrorResponse.swift
//  Habit
//
//  Created by VITOR SHERMON on 01/05/26.
//

import Foundation

struct ErrorResponse: Decodable {
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
