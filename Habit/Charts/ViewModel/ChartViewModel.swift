//
//  ChartViewModel.swift
//  Habit
//
//  Created by VITOR SHERMON on 15/05/26.
//
import SwiftUI
import Foundation
import Combine

class ChartViewModel: ObservableObject {
    
    @Published var entries: [HabitChart] = [
        HabitChart(date: "01/02/1999", value: 2),
        HabitChart(date: "02/02/1999", value: 1),
        HabitChart(date: "03/02/1999", value: 3),
        HabitChart(date: "04/02/1999", value: 5),
        HabitChart(date: "05/02/1999", value: 4),
        HabitChart(date: "06/02/1999", value: 6),
    ]
}
