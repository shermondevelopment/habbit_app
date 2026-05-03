//
//  SignUpView.swift
//  Habit
//
//  Created by VITOR SHERMON on 26/04/26.
//

import SwiftUI
import Combine

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Cadastro").foregroundColor(Color("textColor")).font(.title).bold()
                fullName
                emailField
                birthField
                documentField
                passwordField
                genderField
                button
                
                if case SignUpIUState.error(let value) = viewModel.uiState {
                    Text("").alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("Ok")))
                    }
                }
            }
            
        }.padding(.horizontal, 8)
            .padding(.horizontal, 8)
    }
}


extension SignUpView {
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

extension SignUpView {
    var birthField: some View {
        ZStack {
            DatePicker("Data de nascimento", selection: $viewModel.birthDate, displayedComponents: .date).datePickerStyle(.compact)
        }
    }
}

extension SignUpView {
    var documentField : some View {
        EditTextView(
            text: $viewModel.cpf,
            placeholder: "CPF",
            keyboardType: .numberPad,
            error: "CPF invalido",
            failure: viewModel.cpf.count < 11
        )
    }
}

extension SignUpView {
    var phoneField: some View {
        ZStack {
            TextField("Email", text: $viewModel.phone)
                .background(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.gray, lineWidth: 1))
        }
    }
}

extension SignUpView {
    var fullName : some View {
        EditTextView(
            text: $viewModel.name,
            placeholder: "Nome",
            keyboardType: .default,
            error: "Nome invalido",
            failure: viewModel.name.count < 3
        )
    }
}

extension SignUpView {
    var passwordField : some View {
        EditTextView(
            text: $viewModel.password,
            placeholder: "Senha",
            keyboardType: .emailAddress,
            error: "Senha inválida",
            failure: viewModel.password.count < 6,
            isSecure: true
        )
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue).tag(value)
            }
        }.pickerStyle(SegmentedPickerStyle())
            .padding(.top, 10)
            .padding(.bottom, 20)
    }
}

extension SignUpView {
    var button: some View {
        LoadingButtonView(action: {
            print("entrei")
            viewModel.signUp()
        }, text: "Cadastrar",
                          disabled: !viewModel.email.isEmail() || viewModel.password.count < 8 || viewModel.name.count < 3 || viewModel.cpf.count < 11,
                          loading: self.viewModel.uiState == SignUpIUState.loading,
        )
    }
}


#Preview {
    SignUpView(
        viewModel: SignUpViewModel(
            interactor: SignUpInteractor(),
        )
    )
}

#Preview {
    SignUpView(
        viewModel: SignUpViewModel(
            interactor: SignUpInteractor(),
        )
    ).preferredColorScheme(.dark)
}

