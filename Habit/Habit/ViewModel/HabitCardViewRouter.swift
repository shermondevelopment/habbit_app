//
//  HabitCardViewRouter.swift
//  Habit
//
//  Created by VITOR SHERMON on 06/05/26.
//

import Foundation
import SwiftUI
import Combine

enum HabitCardViewRouter {
    static func makeHabitDetailView(id: Int, name: String, label: String, habitPublishier: PassthroughSubject<Bool, Never>) -> some View {
        print("cheguei", habitPublishier)
        let viewModel = HabitDetailViewModel(id: id, name: name, label: label, interactor: HabitDetailInteractor())
        viewModel.habitsPublishier = habitPublishier
        return HabitDetailView(viewModel: viewModel)
    }
    static func makeChartView(id: Int) -> some View {
        return ChartView(chartViewModel: ChartViewModel())
    }
}
