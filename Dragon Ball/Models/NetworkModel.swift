//
//  NetworkModel.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 13/7/22.
//

import UIKit

enum NetworkError: Error, Equatable {
    case urlError
    case malformedData
    case taskError
    case requestError(Int)
    case dataError
    case tokenError
    case decodingError
}

class NetworkModel {
    
    var session: URLSession
    
    var token: String?
    
    init(urlSession: URLSession = .shared, token: String? = nil) {
        self.session = urlSession
        self.token = token
    }
    
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
        
        let task = session.dataTask(with: request) { data, response, error in
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
        
        let task = session.dataTask(with: request) { data, response, error in
            
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
    
    func getTransformations(id: String, completion: @escaping ([Transformations], NetworkError?) -> Void) {
        guard let url = URL(string: "https://vapor2022.herokuapp.com/api/heros/tranformations") else {
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
        struct BodyTrans: Encodable {
            let id: String
        }
        request.httpBody = try? JSONEncoder().encode(BodyTrans(id: id))
        
        let task = session.dataTask(with: request) { data, response, error in
            guard  error == nil else {
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
            
            guard let trasformationsResponse = try? JSONDecoder().decode([Transformations].self, from: data) else {
                completion([], .decodingError)
                return
            }
            
            completion(trasformationsResponse.sorted { $0.name.compare($1.name, options: .numeric) == .orderedAscending }, nil)


        }
        task.resume()
    }
}
