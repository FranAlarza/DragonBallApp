//
//  LocalDataModelTests.swift
//  Dragon BallTests
//
//  Created by Fran Alarza on 17/7/22.
//

import XCTest
@testable import Dragon_Ball

class LocalDataModelTests: XCTestCase {
    
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        LocalDataModel.deleteToken()
    }

    func testSaveToken() {
        // GIVEN
        let fakeToken = "FakeToken"
        // WHEN
        LocalDataModel.saveToken(token: fakeToken)
        // THEN
        let retrievedToken = LocalDataModel.getToken()
        XCTAssertEqual(fakeToken, retrievedToken)
    }
    
    
    
    func testDeleteToken() throws {
        // GIVEN
        let fakeToken = "FakeToken"
        // WHEN
        LocalDataModel.saveToken(token: fakeToken)
        LocalDataModel.deleteToken()
        // THEN
        let retrievedToken = LocalDataModel.getToken()
        XCTAssertNil(retrievedToken, "Token should be nil")
    }
    
}
