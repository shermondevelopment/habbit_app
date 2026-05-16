//
//  HabitDetailUIState.swift
//  Habit
//
//  Created by VITOR SHERMON on 06/05/26.
//

import Foundation


enum HabitDetailUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
