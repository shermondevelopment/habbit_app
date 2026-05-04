//
//  SigninView.swift
//  Habit
//
//  Created by VITOR SHERMON on 26/04/26.
//

import SwiftUI

struct SigninView: View {
    
    @ObservedObject var viewModel: SigninViewModel

    @State var action: Int? = 0
    @State var navigationHidden = true
    
    var body: some View {
        ZStack {
            if case SignInUIState.goToHomeScreen = viewModel.uiState {
                viewModel.homeView()
            } else {
                NavigationStack {
                    ScrollView(showsIndicators: false) {
                            Spacer(minLength: 100)
                            VStack(alignment: .center, spacing: 20) {
                                Image("logo").resizable().scaledToFit()
                                    .padding(.horizontal, 70)
                                Text("Login")
                                    .foregroundColor(.orange)
                                    .font(Font.system(.title))
                                    .bold()
                                    .padding(.bottom, 8)
                                emailField
                                passwordField
                                button
                                registerLink
                                
                                Text("Copy Right © 2026 - Vitor Sherman")
                                    .foregroundColor(.gray)
                                    .font(Font.system(size: 16).bold())
                                    .padding(.top, 16)
                            }
                         
                        if case SignInUIState.error(let value) = viewModel.uiState {
                            Text("").alert(isPresented: .constant(true)) {
                                Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("Ok")))
                            }
                        }
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 20)
                        .navigationBarTitle("Login", displayMode: .inline)
                        .navigationBarHidden(navigationHidden)
                }
            }
        }
    }
}

extension SigninView {
    var emailField : some View {
        EditTextView(
            text: $viewModel.email,
            placeholder: "Email",
            keyboardType: .emailAddress,
            error: "Email invalido",
            failure: !viewModel.email.isEmail()
        )
    }
}

extension SigninView {
    var passwordField : some View {
        EditTextView(
            text: $viewModel.password,
            placeholder: "Password",
            keyboardType: .default,
            error: "Senha inválida",
            isSecure: true
        )
    }
}

extension SigninView {
    var button: some View {
        LoadingButtonView(action: {
            viewModel.signIn()
        }, text: "Entrar",
                          disabled: !viewModel.email.isEmail() || viewModel.password.count < 8,
           loading: self.viewModel.uiState == SignInUIState.loading,
        )
    }
}

extension SigninView {
    var registerLink: some View {
        VStack {
            Text("Ainda não possui login ativo?")
                .foregroundColor(.gray)
                .padding(.top, 48)
            ZStack {
                NavigationLink(
                    destination: viewModel.signUpView(),
                    label: {
                       Text("Realize seu cadastro")
                })
//                NavigationLink(
//                    destination: Text("Tela de cadastro"),
//                    tag: 1,
//                    selection: $action,
//                    label: { EmptyView() },
//                )
//                Button("Cadastre-se") {
//                    self.action = 1
//                }
            }
        }
    }
}



#Preview {
    SigninView(viewModel: SigninViewModel(interactor: SigninInteractor())).preferredColorScheme(.light)
}

#Preview {
    SigninView(viewModel: SigninViewModel(interactor: SigninInteractor())).preferredColorScheme(.dark)
}

