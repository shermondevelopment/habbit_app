//
//  RemoteDataSource.swift
//  Habit
//
//  Created by VITOR SHERMON on 03/05/26.
//

import Foundation
import Combine

class SignInRemoteDataSource {
    // pattern singleton
    // temos apenas 1 unico objeto vivo dentro da aplicacao
    
    static var shared: SignInRemoteDataSource = SignInRemoteDataSource()
    
    private init() {
        
    }
    
    func login(request: SigninRequest) -> Future<SigninResponse, AppError> {
        return Future<SigninResponse, AppError> { promise in
            WebService.call(path: .login, params: [
                URLQueryItem(name: "username", value: request.email),
                URLQueryItem(name: "password", value: request.password)
            ]) { result in
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
