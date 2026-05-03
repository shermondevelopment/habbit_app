//
//  SignInViewModel.swift
//  Habit
//
//  Created by VITOR SHERMON on 26/04/26.
//

import SwiftUI
import Combine

class SigninViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password: String = ""
    
    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?

    private let publishier = PassthroughSubject<Bool, Never>()
    private let interactor: SigninInteractor
    
    @Published var uiState: SignInUIState = .none
    
    init(interactor: SigninInteractor) {
        self.interactor = interactor
        cancellable = publishier.sink { value in
            print("Usuario criado go to Home \(value)")
            
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
        cancellableRequest?.cancel()
    }
    
    func signIn() {
        self.uiState = .loading
        
        cancellableRequest = interactor.login(loginRequest: SigninRequest(email: email, password: password))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                // aqui acontece o error ou finished
                switch completion {
                    case .failure(let appError):
                    self.uiState = SignInUIState.error(appError.message ?? "Erro desconhecido")
                        break
                case .finished:
                    break
                }
            }, receiveValue: { success in
                // code
                print("deu sucesso")
                let userAuth = UserAuth(idToken: success.accessToken,
                                                              refreshToken: success.refreshToken,
                                        expires: Date().timeIntervalSince1970 + Double(success.expires),
                                                              tokenType: success.tokenType
                                                      )
                self.interactor.insertAuth(userAuth: userAuth)
                self.uiState = .goToHomeScreen
            })
                  
                  //        interactor.login(loginRequest: SigninRequest(email: email, password: password)) { (success, error) in
                  //            if let error = error {
                  //                print("dey errr")
                  //                DispatchQueue.main.async {
                  //                    // main thread
                  //                    self.uiState = .error(error.detail.message)
                  //                }
                  //            }
                  //            if let success = success {
                  //                DispatchQueue.main.async {
                  //                    print("deu sucesso")
                  //                    self.uiState = .goToHomeScreen
                  //                }
                  //            }
                  //        }
    }
    
}

extension SigninViewModel {
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publishier: publishier)
    }
}
