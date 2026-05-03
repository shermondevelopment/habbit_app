//
//  SigninRequest.swift
//  Habit
//
//  Created by VITOR SHERMON on 02/05/26.
//

import Foundation

struct SigninRequest: Encodable {
    let email: String
    let password: String
}
