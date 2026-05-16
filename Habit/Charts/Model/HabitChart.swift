//
//  HabitChart.swift
//  Habit
//
//  Created by VITOR SHERMON on 15/05/26.
//
import SwiftUI
import Foundation

struct HabitChart: Identifiable {
    let id: UUID = UUID()
    let date: String
    let value: Int
}
