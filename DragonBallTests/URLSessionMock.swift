//
//  URLSessionMock.swift
//  Dragon BallTests
//
//  Created by Fran Alarza on 16/7/22.
//

import Foundation

class URLSessionMock: URLSession {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    override init() {}
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSessionDataTaskMock {
            completionHandler(self.data, self.response, self.error)
        }
    }
    
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
