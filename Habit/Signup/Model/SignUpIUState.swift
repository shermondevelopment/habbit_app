//
//  SignUpIUState.swift
//  Habit
//
//  Created by VITOR SHERMON on 26/04/26.
//

import Foundation

enum SignUpIUState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
