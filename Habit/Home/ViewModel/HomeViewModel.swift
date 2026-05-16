//
//  HomeViewModel.swift
//  Habit
//
//  Created by VITOR SHERMON on 26/04/26.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    let viewModel = HabitViewModel(isCharts: false, interactor: HabitInteractor())
    let habitGraphViewModel = HabitViewModel(isCharts: true, interactor: HabitInteractor())
    let profileModel = ProfileViewModel(interactor: ProfileInteractor())
}

extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: viewModel)
    }
    func profileView() -> some View {
        return HomeViewRouter.makeProfileView(viewModel: profileModel)
    }
    func habitForChartView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: habitGraphViewModel)
    }
}
