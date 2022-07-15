//
//  CharacterModel.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 13/7/22.
//

import UIKit

struct Hero: Decodable {
    let name: String
    let favorite: Bool
    let photo: String
    let id: String
    let description: String
}
