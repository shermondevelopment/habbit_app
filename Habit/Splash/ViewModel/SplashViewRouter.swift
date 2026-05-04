//
//  SplashViewRouter.swift
//  Habit
//
//  Created by VITOR SHERMON on 26/04/26.
//

import SwiftUI

enum SplashViewRouter {
    
    static func makeSigninView() -> some View {
        let viewModel = SigninViewModel(interactor: SigninInteractor())
        return SigninView(viewModel: viewModel)
    }
    
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
