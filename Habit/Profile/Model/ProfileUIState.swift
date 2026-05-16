//
//  ProfileUIState.swift
//  Habit
//
//  Created by VITOR SHERMON on 13/05/26.
//

enum ProfileUIState: Equatable {
    case none
    case loading
    case fetchSuccess
    case fetchError(String)
    case updateLoading
    case updateSuccess
    case updateError(String)
}
