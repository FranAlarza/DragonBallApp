//
//  UserDefaultModel.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 15/7/22.
//

import UIKit

private enum Constant {
    static let tokenKey = "KCToken"
}

class LocalDataModel {
    private static let userDefaults = UserDefaults.standard
    
    static func getToken() -> String? {
        userDefaults.string(forKey: Constant.tokenKey)
    }
    
    static func saveToken(token: String) {
        userDefaults.set(token, forKey: Constant.tokenKey)
    }
    
}
