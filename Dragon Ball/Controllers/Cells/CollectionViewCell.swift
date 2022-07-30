//
//  CollectionViewCell.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 10/7/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setData(model: Hero) {
        characterImage.downloadImage(from: model.photo)
        nameLabel.text = model.name
        characterImage.layer.cornerRadius = 8
    }
    
    
}
