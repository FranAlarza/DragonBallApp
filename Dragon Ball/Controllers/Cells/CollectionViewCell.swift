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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(image: String, label: String) {
        characterImage.image = UIImage(named: image)
        nameLabel.text = label
    }

}
