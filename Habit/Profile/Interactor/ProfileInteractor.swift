//
//  ProfileInteractor.swift
//  Habit
//
//  Created by VITOR SHERMON on 13/05/26.
//

//
//  SignUpInteractor.swift
//  Habit
//
//  Created by VITOR SHERMON on 03/05/26.
//

import Foundation
import Combine

// repository or interactor
class ProfileInteractor {
    private let remote: ProfileRemoteDataSource = .shared
//    private let local: LocalDataSource
}

extension ProfileInteractor {
    func fetchUser() -> Future<ProfileResponse, AppError> {
        return remote.fetchUser()
    }
    func updateUser(userId: Int, request: ProfileRequest) -> Future<ProfileResponse, AppError> {
        return remote.updateUser(userId: userId, request: request)
    }
}
