//
//  SignUpViewModel.swift
//  Habit
//
//  Created by VITOR SHERMON on 26/04/26.
//
import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var cpf: String = ""
    @Published var phone: String = ""
    @Published var birthDate: Date = Date()
    @Published var male: String = ""
    @Published var gender: Gender = .male
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    private var cancellableSignup: AnyCancellable?
    private var cancellableSignin: AnyCancellable?
    
    @Published var uiState: SignUpIUState = .none
    
    private var interactor: SignUpInteractor
    
    init(interactor: SignUpInteractor) {
        self.interactor = interactor
//        self.publisher = publishier
    }
    
    deinit {
        cancellableSignup?.cancel()
        cancellableSignin?.cancel()
    }
    
    func signUp() {
        self.uiState = .loading
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateFormatted = formatter.string(from: Date())
        
        //        guard let dateFormatted = dateFormatted else {
        //            self.uiState = .error("Data inválida")
        //        }
        
        print("minha data", dateFormatted)
        
        let signupRequest = SignUpRequest(
            fullName: name,
            email: email,
            password: password,
            document: cpf,
            phone: phone,
            birthday: dateFormatted,
            gender: gender.index
        )
        
       cancellableSignup = interactor.postUser(signupRequest: signupRequest)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                // error or finished
                switch completion {
                case .failure (let appError):
                    self.uiState = .error(appError.message ?? "erro ao fazer login")
                case .finished:
                    break
                }
            }, receiveValue: { created in
                if created {
                    
                    // se tiver criado login
                    
                    self.cancellableSignin = self.interactor.login(signinRequest: SigninRequest(email: self.email, password: self.password))
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .failure (let appError):
                                self.uiState = .error(appError.message ?? "erro ao fazer login")
                                break
                            case .finished:
                                break
                            }
                        } , receiveValue: { successSignin in
                                self.publisher.send(true)
                                self.uiState = .success
                        })
                }
            })
                  
                  //        interactor.postUser(signupRequest: SignUpRequest(
                  //            fullName: name,
                  //            email: email,
                  //            password: password,
                  //            document: cpf,
                  //            phone: phone,
                  //            birthday: dateFormatted,
                  //            gender: gender.index
                  //        )) { (success, error) in
                  //
                  //            if let error = error {
                  //                DispatchQueue.main.async {
                  //                    // main thread
                  //                    self.uiState = .error(error.detail)
                  //                }
                  //            }
                  //
                  //            if let success = success {
                  //
                  //                WebService.login(request: SigninRequest(email: self.email, password: self.password)) { (success, error) in
                  //
                  //                    if let error = error {
                  //                        DispatchQueue.main.async {
                  //                            self.uiState = .error(error.detail.message)
                  //                        }
                  //                    }
                  //
                  //                    if let success = success {
                  //                        DispatchQueue.main.async {
                  //                            self.publisher.send(true)
                  //                            self.uiState = .success
                  //                        }
                  //                    }
                  //                }
                  //
                  //            }
                  //        }
                  
                  //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                  ////            self.uiState = .error("usuario já existente")
                  //            self.uiState = .success
                  //            self.publisher.send(true)
                  //        }
    }
}

extension SignUpViewModel {
    func homeView() -> some View {
        return HomeView(viewModel: HomeViewModel())
    }
}
