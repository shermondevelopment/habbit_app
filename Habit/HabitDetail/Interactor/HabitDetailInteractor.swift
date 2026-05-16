//
//  HabitDetailInteractor.swift
//  Habit
//
//  Created by VITOR SHERMON on 07/05/26.
//


import Foundation
import Combine

// repository or interactor
class HabitDetailInteractor {
    private let remote: HabitDetailRemoteDataSource = .shared
}

extension HabitDetailInteractor {
    func save(habitId: Int, request: HabitValueRequest) -> Future<Bool, AppError> {
        return remote.save(habitId: habitId, request: request)
    }
}
