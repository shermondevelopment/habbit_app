//
//  SignInViewRouter.swift
//  Habit
//
//  Created by VITOR SHERMON on 26/04/26.
//

import SwiftUI
import Combine

enum SignInViewRouter {
    static func makeHomeView() -> some View {
        return HomeView(viewModel: HomeViewModel())
    }
    static func makeSignUpView(publishier: PassthroughSubject<Bool, Never>) -> some View {
        let signupViewModel = SignUpViewModel(interactor: SignUpInteractor())
        signupViewModel.publisher = publishier
        return SignUpView(viewModel: signupViewModel)
    }
}
