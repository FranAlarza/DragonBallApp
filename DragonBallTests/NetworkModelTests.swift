//
//  Dragon_BallTests.swift
//  Dragon BallTests
//
//  Created by Fran Alarza on 6/7/22.
//

import XCTest
@testable import Dragon_Ball

enum ErrorMock: Error {
    case mockCase
}

class NetworkModelTests: XCTestCase {
    
    private var urlSessionMock: URLSessionMock!
    private var sut: NetworkModel!
    
    override func setUpWithError() throws {
        urlSessionMock = URLSessionMock()
        sut = NetworkModel(urlSession: urlSessionMock)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testLoginFailWithError() {
        var error: NetworkError?
        
        //Given
        urlSessionMock.data = nil
        urlSessionMock.error = ErrorMock.mockCase
        
        //When
        sut.login(user: "", password: "") { _, networkError in
            error = networkError
        }
        
        //Then
        XCTAssertEqual(error, .taskError)
    }
    
    
    func testLoginFailWithNoData() throws {
        var error: NetworkError?
        // GIVEN
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        // WHEN
        sut.login(user: "franalarza@gmail.com", password: "dinosaurio") { _, networkError in
            error = networkError
        }
        
        // THEN
        XCTAssertEqual(error, .dataError)
    }
    
    func testLoginWithMockToken() throws {
        var error: NetworkError?
        var retrievedToken: String?
        // GIVEN
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        urlSessionMock.data = "Token".data(using: .utf8)
        
        // WHEN
        sut.login(user: "franalarza@gmail.com", password: "dinosaurio") { data, networkError in
            retrievedToken = data
            error = networkError
        }
        
        // THEN
        XCTAssertNotNil(retrievedToken, "should have recieved a token")
        XCTAssertNil(error, "Should be no error")
    }
    
    func testLoginWithErrorCode() throws {
        var error: NetworkError?
        // GIVEN
        
        
        // WHEN
        sut.login(user: "franalarza@gmail.com", password: "dinosaurio") { _, networkError in
            error = networkError
        }
        
        // THEN
        XCTAssertNotEqual(error, .requestError(200))
    }
    
    // MARK: -GET CHARACTER TESTS-
    
    func testGetCharacterSuccess() throws {
        var error: NetworkError?
        var retrievedCharacters: [Hero]?
        sut.token = "Fake Token"
        
        urlSessionMock.data = getData()
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        sut.getCharacter { characters, networkerror in
            error = networkerror
            retrievedCharacters = characters
        }
        
        XCTAssertTrue(retrievedCharacters?.count ?? 0 > 0)
        XCTAssertEqual(retrievedCharacters?.first?.name, "Maestro Roshi")
        XCTAssertNil(error, "Error should be nil")
    }
    
    func testGetCharacterWithoutToken() throws {
        var error: NetworkError?
        
        urlSessionMock.data = getData()
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        sut.getCharacter { characters, networkerror in
            error = networkerror
        }
        
        XCTAssertEqual(error, .tokenError)
    }
    
    func testGetCharacterWithResponseError() throws {
        var error: NetworkError?
        sut.token = "Fake Token"
        // GIVEN
        urlSessionMock.data = getData(resource: "jsonMalformed")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        // WHEN
        sut.getCharacter { characters, networkerror in
            error = networkerror
        }
        
        // THEN
        XCTAssertNotEqual(error, .requestError(200))
    }
    
    func testGetCharacterWithDataError() throws {
        var error: NetworkError?
        sut.token = "Fake Token"
        
        urlSessionMock.data = nil
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        sut.getCharacter { characters, networkerror in
            error = networkerror
        }
        
        XCTAssertEqual(error, .dataError)
    }
    
    func testGetCharacterWithDecodingError() throws {
        var error: NetworkError?
        var retrievedCharacters: [Hero]?
        sut.token = "Fake Token"
        
        urlSessionMock.data = getData(resource: "jsonMalformed")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        sut.getCharacter { characters, networkerror in
            error = networkerror
            retrievedCharacters = characters
        }
        
        XCTAssertEqual(error, .decodingError)
        XCTAssertTrue(retrievedCharacters?.count == 0)
    }
    
    
    // MARK: - GET TRANSFORMATIONS TESTS -
    
    func testGetTransformationsSuccess() throws {
        var error: NetworkError?
        var retrievedTransformations: [Transformations]?
        sut.token = "Fake Token"
        
        urlSessionMock.data = getData(resource: "transformation")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        sut.getTransformations(id: "", completion: { transformations, Networkerror in
            error = Networkerror
            retrievedTransformations = transformations
        })

        XCTAssertEqual(error, nil)
        XCTAssertTrue(retrievedTransformations!.count > 0)
        XCTAssertEqual(retrievedTransformations?.first?.name, "name")
    }
    
    func testGetTransformationsWithTokenError() throws {
        var error: NetworkError?
        var retrievedTransformations: [Transformations]?
        
        urlSessionMock.data = getData(resource: "transformations")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        sut.getTransformations(id: "000", completion: { transformations, networkError in
            error = networkError
            retrievedTransformations = transformations
        })
        
        XCTAssertTrue(retrievedTransformations?.count == 0)
        XCTAssertEqual(error, .tokenError)
    }
    
    func testGetTransformationsWithDataError() throws {
        var error: NetworkError?
        var retrievedTransformations: [Transformations]?
        sut.token = "Fake Token"
        
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        sut.getTransformations(id: "000", completion: { transformations, networkError in
            error = networkError
            retrievedTransformations = transformations
        })
        
        XCTAssertTrue(retrievedTransformations?.count == 0)
        XCTAssertEqual(error, .dataError)
    }
    
    func testGetTransformationsWithStatusError() throws {
        var error: NetworkError?
        sut.token = "Fake Token"
        
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        sut.getTransformations(id: "000", completion: { transformations, networkError in
            error = networkError
        })
        
        XCTAssertNotEqual(error, .requestError(200))
        XCTAssertNotNil(error, "error should be not nil")
    }
    
    
    
}


extension NetworkModelTests {
    func getData(resource: String = "heroes") -> Data? {
        let bundle = Bundle(for: NetworkModelTests.self)
        
        guard let path = bundle.path(forResource: resource, ofType: "json") else { return nil }
        
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
    
}


