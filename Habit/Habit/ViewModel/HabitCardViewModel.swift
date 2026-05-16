//
//  HabitCardViewModel.swift
//  Habit
//
//  Created by VITOR SHERMON on 04/05/26.
//

import Foundation
import SwiftUI
import Combine

struct HabitCardViewModel: Identifiable, Equatable {
    
    var id: Int = 0
    var icon: String = ""
    var date: Date?
    var name: String = ""
    var label: String = ""
    var value: Int?
    var state: Color = .green
    
    var habitPublisher: PassthroughSubject<Bool, Never>
    
    static func == (lhs: HabitCardViewModel, rhs: HabitCardViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension HabitCardViewModel {
    func HabitDetailView() -> some View {
        return HabitCardViewRouter.makeHabitDetailView(id: id, name: name, label: label, habitPublishier: habitPublisher)
    }
    func chartView() -> some View {
        return HabitCardViewRouter.makeChartView(id: id)
    }
}
