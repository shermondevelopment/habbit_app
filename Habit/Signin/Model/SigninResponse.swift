//
//  SigninResponse.swift
//  Habit
//
//  Created by VITOR SHERMON on 02/05/26.
//

import Foundation

struct SigninResponse: Decodable {
   let accessToken: String
   let refreshToken: String
   let expires: Int
   let tokenType: String
    
   enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
       case refreshToken = "refresh_token"
       case expires
       case tokenType = "token_type"
    }
}
