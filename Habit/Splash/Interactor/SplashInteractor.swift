//
//  SplashInteractor.swift
//  Habit
//
//  Created by VITOR SHERMON on 03/05/26.
//

import Foundation
import Combine

// repository or interactor
class SplashInteractor {
    private let remote: SplashRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

extension SplashInteractor {
    func fetchAuth() -> Future<UserAuth?, Never> {
        return local.getUserAuth()
    }
    
    func insertAuth(userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
    
    func refreshToken(refreshRequest request: RefreshRequest) -> Future<SigninResponse, AppError> {
        return remote.refreshToken(request: request)
    }
    
    
}
