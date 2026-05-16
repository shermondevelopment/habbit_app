//
//  ProfileRemoteDataSource.swift
//  Habit
//
//  Created by VITOR SHERMON on 13/05/26.
//

//
//  RemoteDataSource.swift
//  Habit
//
//  Created by VITOR SHERMON on 03/05/26.
//

import Foundation
import Combine

class ProfileRemoteDataSource {
    // pattern singleton
    // temos apenas 1 unico objeto vivo dentro da aplicacao
    
    static var shared: ProfileRemoteDataSource = ProfileRemoteDataSource()
    
    private init() {
        
    }
    
    func fetchUser() -> Future<ProfileResponse, AppError> {
        return Future { promise in
            WebService.call(path: .fetchUser, method: .get) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(ErrorResponse.self, from: data)
                        //completion(nil, response)
                        print("ëu aqui", response)
                        promise(.failure(AppError.response(message: response?.detail ?? "Erro interno no servidor")))
                    }
                    break
                case .success(let data):
                    print("successo sherman 12", data)
                    // completion(true, nil)
                    let decode = JSONDecoder()
                    let response = try? decode.decode(ProfileResponse.self, from: data)
                    guard let res = response else {
                        print("Erro no codeble profile")
                        return
                    }
                    
                    promise(.success(res))
                    break
                }
            }
        }
    }
    
    func updateUser(userId: Int, request: ProfileRequest) -> Future<ProfileResponse, AppError> {
        let path = String(format: WebService.Endpoint.updateUser.rawValue, userId)
        return Future { promise in
            WebService.call(path: path, method: .put, body: request) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(ErrorResponse.self, from: data)
                        //completion(nil, response)
                        print("ëu aqui", response)
                        promise(.failure(AppError.response(message: response?.detail ?? "Erro interno no servidor")))
                    }
                    break
                case .success(let data):
                    print("atualizou perfil", data)
                    // completion(true, nil)
                    let decode = JSONDecoder()
                    let response = try? decode.decode(ProfileResponse.self, from: data)
                    guard let res = response else {
                        print("Erro no codeble profile")
                        return
                    }
                    
                    promise(.success(res))
                    break
                }
            }
        }
    }
}

