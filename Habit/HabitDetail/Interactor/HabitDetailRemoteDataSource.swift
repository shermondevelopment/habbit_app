//
//  HabitDetailRemoteDataSource.swift
//  Habit
//
//  Created by VITOR SHERMON on 07/05/26.
//

//
//  RemoteDataSource.swift
//  Habit
//
//  Created by VITOR SHERMON on 03/05/26.
//

import Foundation
import Combine

class HabitDetailRemoteDataSource {
    // pattern singleton
    // temos apenas 1 unico objeto vivo dentro da aplicacao
    
    static var shared: HabitDetailRemoteDataSource = HabitDetailRemoteDataSource()
    
    private init() {
        
    }
    
    func save(habitId: Int, request: HabitValueRequest) -> Future<Bool, AppError> {
        return Future<Bool, AppError> { promise in
            let path = String(format: WebService.Endpoint.habitValues.rawValue, habitId)
            WebService.call(path: path, method: .post, body: request) { result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(SignninErrorResponse.self, from: data)
                            print(response)
                            promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                    }
                    break
                case .success(let data):
                    promise(.success(true))
                }
            }
        }
    }
}
