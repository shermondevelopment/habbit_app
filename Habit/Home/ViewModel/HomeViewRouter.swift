//
//  HomeViewRouter.swift
//  Habit
//
//  Created by VITOR SHERMON on 04/05/26.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    static func makeHabitView() -> some View {
        let viewModel = HabitViewModel()
        return HabitView(viewModel: viewModel)
    }
}
