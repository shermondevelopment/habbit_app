//
//  HabitView.swift
//  Habit
//
//  Created by VITOR SHERMON on 04/05/26.
//
import SwiftUI
 
struct HabitView: View {
    
    @ObservedObject var viewModel: HabitViewModel
    
    var body: some View {
        ZStack {
            if case HabitUIState.loading = viewModel.uiState {
                progress
            } else if case HabitUIState.emptyList = viewModel.uiState {
                EmptyView()
            } else if case HabitUIState.fullList = viewModel.uiState {
                List {
                    Text("aqui")
                    Text("Hello, World!")
                }
            }
        }
    }
}

extension HabitView {
    var progress: some View {
        ProgressView()
    }
}

#Preview {
    HabitView(viewModel: HabitViewModel())
}
