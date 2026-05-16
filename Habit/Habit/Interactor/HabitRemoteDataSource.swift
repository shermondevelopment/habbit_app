//
//  RemoteDataSource.swift
//  Habit
//
//  Created by VITOR SHERMON on 03/05/26.
//

import Foundation
import Combine

class HabitRemoteDataSource {
    // pattern singleton
    // temos apenas 1 unico objeto vivo dentro da aplicacao
    
    static var shared: HabitRemoteDataSource = HabitRemoteDataSource()
    
    private init() {
        
    }
    
    func fetchHabits() -> Future<[HabitResponse], AppError> {
        return Future<[HabitResponse], AppError> { promise in
            WebService.call(path: .habits, method: .get) { result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignninErrorResponse.self, from: data)
                        print("porque vitor", response)
                        promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                    }
                    if error == .badRequest {
                        promise(.failure(AppError.response(message: "Internal server error")))
                    }
                    break
                case .success(let data):
                    
                    //completion(response, nil)
                    do {
                        let decoder = JSONDecoder()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        
                        decoder.dateDecodingStrategy = .formatted(formatter)
                        let response = try decoder.decode([HabitResponse].self, from: data)
                        promise(.success(response))
                    } catch {
                        print("meu error bruna", error)
                        promise(.failure(AppError.response(message: "Erro desconhecido no servidor")))
                        return
                    }
                }
            }
        }
    }
}

