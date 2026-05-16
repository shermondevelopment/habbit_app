//
//  HomeViewRouter.swift
//  Habit
//
//  Created by VITOR SHERMON on 04/05/26.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    static func makeHabitView(viewModel: HabitViewModel) -> some View {
        return HabitView(viewModel: viewModel)
    }
    static func makeProfileView(viewModel: ProfileViewModel) -> some View {
        return ProfileView(viewModel: viewModel)
    }
}
