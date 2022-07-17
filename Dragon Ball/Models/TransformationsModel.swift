//
//  TransformationsModel.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 16/7/22.
//

import UIKit

struct TransformationsId: Decodable {
    let id: String
}

struct Transformations: Decodable{
    
    let hero: TransformationsId
    let name: String
    let photo: String
    let description: String
    
}


