//
//  ProfileView.swift
//  Habit
//
//  Created by VITOR SHERMON on 10/05/26.
//

import Foundation
import SwiftUI
import Combine

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var disableDone: Bool {
        viewModel.fullNameValidation.failure || viewModel.birthDateValidation.failure ||
        viewModel.phoneValidation.failure || viewModel.birthDateValidation.failure
    }
    
    var body: some View {
        ZStack {
            
            if case ProfileUIState.loading = viewModel.uiState {
                ProgressView()
            } else {
                NavigationStack {
                    VStack {
                        Form {
                            Section(header: Text("Dados cadastrais")) {
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text("Nome")
                                        Spacer()
                                        TextField("Digite o nome", text: $viewModel.fullNameValidation.value)
                                            .multilineTextAlignment(.trailing)
                                    }
                                    
                                    if viewModel.fullNameValidation.failure {
                                        Text("O nome é obrigatório")
                                            .foregroundColor(.red)
                                            .opacity(0.7)
                                            .transition(.move(edge: .top).combined(with: .opacity))
                                    }
                                }
                                .animation(.easeInOut(duration: 0.25), value: viewModel.fullNameValidation.failure)
                                HStack {
                                    Text("E-mail")
                                    Spacer()
                                    TextField("", text: $viewModel.email)
                                        .multilineTextAlignment(.trailing)
                                        .disabled(true)
                                }
                                HStack {
                                    Text("CPF")
                                    Spacer()
                                    TextField("Digite seu cpf", text: $viewModel.cpf)
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.trailing)
                                        .disabled(true)
                                }
                                VStack {
                                    HStack {
                                        Text("Celular")
                                        Spacer()
                                        TextField("Digite o seu celular", text: $viewModel.phoneValidation.value)
                                            .keyboardType(.numberPad)
                                            .multilineTextAlignment(.trailing)
                                    }
                                    if viewModel.phoneValidation.failure {
                                        Text("Informe telefone valido")
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.red)
                                            .opacity(0.7)
                                            .transition(.move(edge: .top).combined(with: .opacity))
                                    }
                                }.animation(.easeInOut(duration: 0.25), value: viewModel.phoneValidation.failure)
                                
                                VStack {
                                    HStack {
                                        Text("Data de nascimento")
                                        Spacer()
                                        TextField("Digite sua data", text: $viewModel.birthDateValidation.value)
                                            .keyboardType(.numberPad)
                                            .multilineTextAlignment(.trailing)
                                    }
                                    if viewModel.birthDateValidation.failure {
                                        Text("Data de nascimento inválida")
                                            .foregroundColor(.red)
                                            .opacity(0.7)
                                            .transition(.move(edge: .top).combined(with: .opacity))
                                    }
                                }.animation(.easeInOut(duration: 0.25), value: viewModel.phoneValidation.failure)
                                
                                NavigationLink(destination: GenderSelectView(
                                    selectedGender: $viewModel.selectGender,
                                    title: "Selecione o sexo",
                                    genders: Gender.allCases),
                                               label:  {
                                    Text("Gênero")
                                    Spacer()
                                    Text(viewModel.selectGender.rawValue ?? "Selecionar")
                                }
                                )
                            }
                        }
                    }
                    .navigationBarTitle(Text("Perfil"), displayMode: .automatic)
                    .navigationBarItems(trailing: Button(action: {
                        viewModel.updateProfile()
                    }, label: {
                        if case ProfileUIState.updateLoading = viewModel.uiState {
                            ProgressView()
                        } else {
                            Image(systemName: "checkmark")
                                .foregroundColor(.orange)
                        }
                        
                        if case ProfileUIState.updateError(let value) = viewModel.uiState {
                            Text("").alert(isPresented: .constant(true)) {
                                Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("Ok")) {
                                    viewModel.uiState = .none
                                })
                            }
                        }
                    
                    })
                        .alert(isPresented: .constant(viewModel.uiState == .updateSuccess)) {
                            Alert(title: Text("Habit"), message: Text("Dados atualizado com sucesso"), dismissButton: .default(Text("Ok")))
                        }
                        .opacity(disableDone ? 0 : 1)
                    )
                    
                }
            }
            if case ProfileUIState.fetchError(let value) = viewModel.uiState {
                Text("").alert(isPresented: .constant(true)) {
                    Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("Ok")))
                }
            }
        }.onAppear(perform: viewModel.fetchUser)
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(interactor: ProfileInteractor()))
}
