//
//  TransformationsViewCell.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 15/7/22.
//

import UIKit

class TransformationsViewCell: UITableViewCell {

    @IBOutlet weak var imageTrans: UIImageView!
    @IBOutlet weak var nameTrans: UILabel!
    @IBOutlet weak var descriptionTrans: UILabel!
    
    
    func setData(model: Transformations) {
        imageTrans.downloadImage(from: model.photo)
        nameTrans.text = model.name
        descriptionTrans.text = model.description
    }
    
}
