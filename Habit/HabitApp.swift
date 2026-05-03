//
//  HabitApp.swift
//  Habit
//
//  Created by VITOR SHERMON on 25/04/26.
//

import SwiftUI

@main
struct HabitApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        }
    }
}
