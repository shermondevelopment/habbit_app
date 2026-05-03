//
//  SignupResponse.swift
//  Habit
//
//  Created by VITOR SHERMON on 01/05/26.
//

struct SignupResponse: Decodable {
    let detail: String?
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
