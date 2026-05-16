//
//  ProfileViewModel.swift
//  Habit
//
//  Created by VITOR SHERMON on 10/05/26.
//

import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    var userId: Int?
    @Published var name: String = "Vitor"
    @Published var email: String = "victor.shermon@gmail.com"
    @Published var cpf: String = "000.000.000-00"
    @Published var phone: String = "(11) 9 99999-9999"
    @Published var birthday: String = "09/02/1999"
    @Published var selectGender: Gender = .male
    
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthDateValidation = BirthDateValidation()
    
    @Published var uiState: ProfileUIState = .none
    
    private var cancellable: AnyCancellable?
    private var cancellableUpdateProfile: AnyCancellable?
    
    private let interactor: ProfileInteractor
    
    init (interactor: ProfileInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
        cancellableUpdateProfile?.cancel()
    }
    
    func fetchUser() {
        self.uiState = .loading
        cancellable = interactor.fetchUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch (completion) {
                case .failure(let appError):
                    self.uiState = .fetchError(appError.message ?? "Erro ao atualizar perfil")
                    break
                case .finished:
                    break
                }
            }, receiveValue: { response in
                
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "pt_BR")
                formatter.dateFormat = "yyyy-MM-dd"
                let dateFormatted = formatter.date(from: response.birthday)
                
                guard let dateFormatted = dateFormatted else {
                    self.uiState = .fetchError("Data inválida \(response.birthday)")
                    return
                }
                
                formatter.dateFormat = "dd/MM/yyyy"
                let birtday = formatter.string(from: dateFormatted)
                
                self.userId = Int(response.id)
                self.email = response.email
                self.cpf = response.document
                self.phone = response.phone
                self.birthday = birtday
                self.name = response.fullName
                self.selectGender = Gender.allCases[response.gender]
                self.uiState = .fetchSuccess
            })
    }
    
    func updateProfile() {
        self.uiState = .updateLoading
        
        guard let userId = userId else { return }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthDateValidation.value)
        
        guard let dateFormatted = dateFormatted else {
            self.uiState = .updateError("Data inválida \(birthday)")
            return
        }
        
        formatter.dateFormat = "yyyy-MM-dd"
        let birthdayFormatted = formatter.string(from: dateFormatted)
        
        cancellableUpdateProfile = interactor.updateUser(userId: userId,
                                   request: ProfileRequest(fullName: self.name,
                                                           phone: self.phone,
                                                           birthday: birthdayFormatted,
                                                           gender: selectGender.index,
                                    ))
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            switch (completion) {
            case .failure(let appError):
                self.uiState = .updateError(appError.message ?? "Erro ao atualizar perfil")
                break
            case .finished:
                break
            }
        }, receiveValue: { value in
            self.uiState = .updateSuccess
        })
        
    }
    
    class FullNameValidation: ObservableObject {
        @Published var failure: Bool = false
        
        var value: String = "Vitor shermon" {
            didSet  {
                failure = value.count < 3
            }
        }
    }
    
    class PhoneValidation: ObservableObject {
        @Published var failure: Bool = false
        
        var value: String = "88981225040" {
            didSet  {
                failure = value.count < 10 || value.count >= 12
            }
        }
    }
    
    class BirthDateValidation: ObservableObject {
        @Published var failure: Bool = false
        
        var value: String = "09/02/1999" {
            didSet  {
                failure = value.count != 10
            }
        }
    }
}
