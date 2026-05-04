//
//  SplashRemoteDataSource.swift
//  Habit
//
//  Created by VITOR SHERMON on 03/05/26.
//

import Foundation
import Combine

class SplashRemoteDataSource {
    // pattern singleton
    // temos apenas 1 unico objeto vivo dentro da aplicacao
    
    static var shared: SplashRemoteDataSource = SplashRemoteDataSource()
    
    private init() {
        
    }
    
    func refreshToken(request: RefreshRequest) -> Future<SigninResponse, AppError> {
        return Future<SigninResponse, AppError> { promise in
            WebService.call(path: .refreshToken, method: .put, body: request) { result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unauthorized {
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(SignninErrorResponse.self, from: data)
                            print(response)
                            promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                            // completion(nil, response)
                        }
                        if error == .badRequest {
                            promise(.failure(AppError.response(message: "Internal server error")))
                        }
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(SigninResponse.self, from: data)
                    //completion(response, nil)
                    guard let response = response else {
                        print("error de pass")
                        promise(.failure(AppError.response(message: "Erro desconhecido no servidor")))
                        return
                    }
                    promise(.success(response))
                    break
                }
            }
        }
    }
}
