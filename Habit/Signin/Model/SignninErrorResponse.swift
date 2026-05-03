//
//  SignninErrorResponse.swift
//  Habit
//
//  Created by VITOR SHERMON on 02/05/26.
//

import Foundation

struct SignninErrorResponse: Decodable {
    let detail: SigninDetailResponse
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}


struct SigninDetailResponse: Decodable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}
