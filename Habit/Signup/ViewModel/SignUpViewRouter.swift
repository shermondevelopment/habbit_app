//
//  SignUpViewRouter.swift
//  Habit
//
//  Created by VITOR SHERMON on 26/04/26.
//
import SwiftUI
import Combine

enum SignUpViewRouter {
    static func makeHome() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
