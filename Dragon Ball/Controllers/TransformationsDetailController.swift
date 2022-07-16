//
//  TransformationsDetailController.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 16/7/22.
//

import UIKit

class TransformationsDetailController: UIViewController {

    @IBOutlet weak var transImage: UIImageView!
    @IBOutlet weak var transName: UILabel!
    @IBOutlet weak var transDescription: UILabel!
    
    private var transformations: Transformations?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transImage.downloadImage(from: transformations?.photo ?? "")
        transName.text = transformations?.name
        transDescription.text = transformations?.description
    }

    func setData(model: Transformations) {
        transformations = model
    }
}
