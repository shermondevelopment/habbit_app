//
//  SignInUIState.swift
//  Habit
//
//  Created by VITOR SHERMON on 26/04/26.
//

import Foundation

enum SignInUIState: Equatable {
    case none
    case leading
    case loading
    case goToHomeScreen
    case error(String)
}
