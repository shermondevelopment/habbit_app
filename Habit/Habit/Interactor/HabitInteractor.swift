//
//  HabitInteractor.swift
//  Habit
//
//  Created by VITOR SHERMON on 05/05/26.
//

//
//  SigninInteractor.swift
//  Habit
//
//  Created by VITOR SHERMON on 03/05/26.
//

import Foundation
import Combine

// repository or interactor
class HabitInteractor {
    private let remote: HabitRemoteDataSource = .shared
}

extension HabitInteractor {
    func fetchHabits() -> Future<[HabitResponse], AppError> {
        return remote.fetchHabits()
    }
}
