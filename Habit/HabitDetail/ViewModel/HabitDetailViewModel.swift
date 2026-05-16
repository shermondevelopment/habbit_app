//
//  HabitDetailViewModel.swift
//  Habit
//
//  Created by VITOR SHERMON on 06/05/26.
//

import Foundation
import SwiftUI
import Combine

class HabitDetailViewModel: ObservableObject {
    
    @Published var uiState: HabitDetailUIState = .none
    @Published var value = ""
    
    private var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    var habitsPublishier: PassthroughSubject<Bool, Never>?
    
    var id: Int
    var name: String
    var label: String
    var interactor: HabitDetailInteractor

    
    init(id: Int, name: String, label: String, interactor: HabitDetailInteractor) {
        self.id = id
        self.name = name
        self.label = label
        self.interactor = HabitDetailInteractor()
    }
    
    deinit {
        cancellable?.cancel()
        for cancellable in cancellables {
            cancellable.cancel( )
        }
    }
    
    func save() {
        uiState = .loading
        
        cancellable = interactor.save(habitId: id, request: HabitValueRequest(value: value))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let err):
                    self.uiState = .error(err.message ?? "Falha interna")
                case .finished:
                    break
                }
            }, receiveValue: { created in
                if created {
                    self.uiState = .success
                    self.habitsPublishier?.send(created)
                }
            })
    }
}
