//
//  SignUpInteractor.swift
//  Habit
//
//  Created by VITOR SHERMON on 03/05/26.
//

import Foundation
import Combine

// repository or interactor
class SignUpInteractor {
    private let remote: SignUpRemoteDataSource = .shared
    private let remoteSignin: SignInRemoteDataSource = .shared
//    private let local: LocalDataSource
}

extension SignUpInteractor {
    func postUser(signupRequest request: SignUpRequest) -> Future<Bool, AppError> {
        return remote.postUser(request: request)
    }
    func login(signinRequest request: SigninRequest) -> Future<SigninResponse, AppError> {
        return remoteSignin.login(request: request)
    }
}
