//
//  HabitViewModel.swift
//  Habit
//
//  Created by VITOR SHERMON on 04/05/26.
//
import Foundation
import SwiftUI
import Combine

class HabitViewModel: ObservableObject {
    @Published var showErrorAlert = false
    @Published var uiState = HabitUIState.loading
    
    @Published var title = "Atenção"
    @Published var headLine = "Fique ligado"
    @Published var description = "Você está atrasado nos hábitos"
    
    @Published var opened: Bool = false
    
    private let habitPublisher = PassthroughSubject<Bool, Never>()
    
    private var cancellableRequest: AnyCancellable?
    private let interactor: HabitInteractor
    private var cancellableNotify: AnyCancellable?
    
    var isCharts: Bool
    
    init(isCharts: Bool, interactor: HabitInteractor) {
        self.isCharts = isCharts
        self.interactor = interactor
        
        cancellableNotify = habitPublisher.sink(receiveValue: { saved in
                print(saved, "aqui")
            self.onAppear()
        })
    }
    
    deinit {
        cancellableRequest?.cancel()
    }
    
    func onAppear() {
        self.opened = true
        self.uiState = .loading
        
        cancellableRequest = self.interactor.fetchHabits()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print("voce vanessa", completion)
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    self.uiState = .error(err.message ?? "Falha ao buscar dados da api")
                    self.showErrorAlert = true
                }
            }, receiveValue: { values in
                if values.isEmpty {
                    self.uiState = .emptyList
                    
                    self.title = ""
                    self.headLine = "Fique Ligado"
                    self.description = "Você não possui nenhum hábito"
                }
                
                if values.count > 0 {
                    self.uiState = .fullList(
                        values.map { item in
                            
                            var state = Color.green
                            self.title = "Muito Bom"
                            self.headLine = "Seus hábitos estão em dias"
                            self.description = "Continue assim"
                            
                            if let lastDate = item.lastDate {
                                if lastDate < Date() {
                                    state = .red
                                    self.title = "Que pena"
                                    self.headLine = "Fique ligado, você está atrasado nos habbitos"
                                }
                            }
                            
                            return HabitCardViewModel(
                                id: item.id,
                                icon: item.iconUrl ?? "",
                                date: item.lastDate,
                                name: item.name,
                                label: item.label,
                                value: item.value,
                                state: state,
                                habitPublisher: self.habitPublisher
                            )
                        }
                    )
                }
            })
        
    }
}

