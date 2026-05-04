//
//  SplashViewModel.swift
//  Habit
//
//  Created by VITOR SHERMON on 26/04/26.
//

import SwiftUI
import Combine

class SplashViewModel: ObservableObject {
    @Published var uiState: SplashUIState = .loading
    
    private var cancellableAuth: AnyCancellable?
    private var cancellableRefresh: AnyCancellable?

    private let interactor: SplashInteractor

    
    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableAuth?.cancel()
        cancellableRefresh?.cancel()
    }

    
    func onAppear() {
        cancellableAuth = interactor.fetchAuth()
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                if userAuth == nil {
                    self.uiState = .goToSignInScreen
                } else if Date().timeIntervalSince1970 > userAuth!.expires {
                    print("expirou")
                    let request = RefreshRequest(refreshToken: userAuth!.refreshToken)
//                    print("meu expire in \(userAuth?.expires)")
                    self.cancellableRefresh = self.interactor.refreshToken(refreshRequest: request)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            print("Falho shermon")
                            switch (completion) {
                            case .failure(_):
                                self.uiState = .goToSignInScreen
                                break
                            default:
                                print("brekou")
                                break
                            }
                        }, receiveValue: { success in
                            print("meu refresh token \(success.refreshToken)")
                            let userAuth = UserAuth(idToken: success.accessToken,
                                                    refreshToken: success.refreshToken,
                                                    expires: Date().timeIntervalSince1970 + Double(success.expires),
                                                    tokenType: success.tokenType
                            )
                            self.uiState = .goToHomeScreen
                            
                        })
                }
                else {
                    self.uiState = .goToHomeScreen
                }
            }
        // se userAuth == nulo -> tela de login
        
        // senao ser userAuth != && expirou -> authToken
        
        // senao -> Tela Principal
        // faz algo assicrono e muda o estado da uiState
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.uiState = .goToSignInScreen
//        }
    }
}


extension SplashViewModel {
    func signinView() -> some View {
        return SplashViewRouter.makeSigninView()
    }
    
    func homeView() -> some View {
        return SplashViewRouter.makeHomeView()
    }
}
