//
//  WebService.swift
//  Habit
//
//  Created by VITOR SHERMON on 29/04/26.
//
import Foundation
import Combine

enum WebService {
    
    enum Endpoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        
        case postUser = "/users"
        case login = "/auth/login"
        case refreshToken = "/auth/refresh-token"
    }
    
    enum NetWorkError {
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    enum Result {
        case success(Data)
        case failure(NetWorkError, Data?)
    }
    
    enum ContentType: String {
        case json = "application/json"
        case formUrlEncoded = "application/x-www-form-urlencoded"
    }
    
    private static func compleUrl(path: Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path.rawValue)") else { return nil }
                
        return URLRequest(url: url)
    }
    
    private static func call(path: Endpoint, method: Method, contentType: ContentType, data: Data?, completion: @escaping (Result) -> Void) {
        guard let jsonData = try? JSONEncoder().encode(data) else { return }
        guard var urlRequest = compleUrl(path: path) else { return }
        
        _ = LocalDataSource.shared.getUserAuth()
            .sink { userAuth in
                if let userAuth = userAuth {
                    print("Token", userAuth.idToken)
                    print("type", userAuth.tokenType)
                    urlRequest.setValue("\(userAuth.tokenType) \(userAuth.idToken)", forHTTPHeaderField: "Authorization")
                }
                urlRequest.httpMethod = method.rawValue
                urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
                urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
                urlRequest.httpBody = data
                
                let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    guard let data = data, error == nil else {
                        completion(.failure(.internalServerError, nil))
                        return
                    }
                    
                    
                    if let r = response as? HTTPURLResponse {
                        print("meu endpoint \(path.rawValue)")
                        print("meu metodo \(method.rawValue)")
                        print("shermon", r.statusCode)
                        switch r.statusCode {
                        case 400:
                            completion(.failure(.badRequest, data))
                             break
                        case 401:
                            completion(.failure(.unauthorized, data))
                        case 404:
                            completion(.failure(.notFound, data))
                        case 200:
                            completion(.success(data))
                        case 500:
                            completion(.failure(.internalServerError, data))
                        default:
                            break
                        }
                    }
                }
                
                task.resume()
            }
       
    }
    
    public static func call<T: Encodable>(path: Endpoint, method: Method = .get, body: T, completion: @escaping (Result) -> Void) {
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        call(path: path, method: method, contentType: .json, data: jsonData, completion: completion)
    }
    
    public static func call(path: Endpoint, method: Method = .post, params: [URLQueryItem]?, completion: @escaping (Result) -> Void) {
        guard var urlRequest = compleUrl(path: path) else { return }
        guard let absoluteUrl = urlRequest.url?.absoluteString else { return }
        var components = URLComponents(string: absoluteUrl)
        guard var components else { return }
        components.queryItems = params
        call(path: path, method: method, contentType: .formUrlEncoded, data: components.query?.data(using: .utf8), completion: completion)
    }
    

    
}
