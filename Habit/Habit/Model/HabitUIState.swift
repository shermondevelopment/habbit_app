//
//  HabitUIState.swift
//  Habit
//
//  Created by VITOR SHERMON on 04/05/26.
//

import Foundation

enum HabitUIState: Equatable {
    case loading
    case emptyList
    case fullList([HabitCardViewModel])
    case error(String)
}
