//
//  HabitViewModel.swift
//  Habit
//
//  Created by VITOR SHERMON on 04/05/26.
//
import Foundation
import SwiftUI
import Combine

class HabitViewModel: ObservableObject {
    @Published var uiState = HabitUIState.loading
}

