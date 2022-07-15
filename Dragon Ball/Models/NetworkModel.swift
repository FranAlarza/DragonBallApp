//
//  NetworkModel.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 13/7/22.
//

import UIKit

enum NetworkError: Error {
    case urlError
    case malformedData
    case taskError
    case requestError(Int)
    case dataError
    case tokenError
    case decodingError
}

class NetworkModel {
    
    var token: String?
    
    static let shared = NetworkModel()
    
    func login(user: String, password: String,  completion: @escaping (String?, NetworkError?) -> Void) {
        guard let url = URL(string: "https://vapor2022.herokuapp.com/api/auth/login") else {
            completion(nil, .urlError)
            return
        }
        
        let loginString = String(format: "%@:%@", user, password)
        guard let dataString = loginString.data(using: .utf8) else {
            completion(nil, .malformedData)
            return
        }
        
        let base64DataString = dataString.base64EncodedString()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64DataString)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else{
                completion(nil, .taskError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(nil, .requestError((response as? HTTPURLResponse)?.statusCode ?? 0))
                return
            }
            
            guard let data = data else {
                completion(nil, .dataError)
                return
            }
            
            guard let token = String(data: data, encoding: .utf8) else {
                completion(nil, .tokenError)
                return
            }
            
            self.token = token
            completion(token, nil)
            
        }
        task.resume()
        
    }
    
    func getCharacter(name: String = "", completion: @escaping ([Hero], NetworkError?) -> Void) {
        guard let url = URL(string: "https://vapor2022.herokuapp.com/api/heros/all") else {
            completion([], .urlError)
            return
        }
        
        guard let token = self.token else {
            completion([], .tokenError)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        struct Body: Encodable {
            let name: String
        }
        
        let body = Body(name: name)
        request.httpBody = try? JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else{
                completion([], .taskError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion([], .requestError((response as? HTTPURLResponse)?.statusCode ?? 0))
                return
            }
            
            guard let data = data else {
                completion([], .dataError)
                return
            }
            
            guard let heroesResponse = try? JSONDecoder().decode([Hero].self, from: data) else {
                completion([], .decodingError)
                return
            }
            
            completion(heroesResponse, nil)
        }
        
        task.resume()
    }
}
