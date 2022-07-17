//
//  DetailViewController.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 11/7/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var tranformations: [Transformations] = []
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var transformationsButton: UIButton!
    
    private var hero: Hero?
    override func viewDidLoad() {
        super.viewDidLoad()
        transformationsButton.alpha = 0
        guard let hero = hero else {
            return
        }
        self.navigationItem.leftBarButtonItem?.title = "Heroes"
        self.title = hero.name
        heroImage.downloadImage(from: hero.photo)
        heroName.text = hero.name
        heroDescription.text = hero.description
        
        guard let token = LocalDataModel.getToken() else { return }
        // Network Call
        let networkModel = NetworkModel(token: token)
        networkModel.getTransformations(id: hero.id) { transform, error in
            DispatchQueue.main.async {
                self.tranformations = transform
                if self.tranformations.count > 0 {
                    self.transformationsButton.alpha = 1
                }
                
            }
        }
        
    }
    
    
    
    func setModel(model: Hero) {
        hero = model
    }

    @IBAction func onTapButton(_ sender: Any) {
        let nextVC = TransformViewController()
        nextVC.transformations = tranformations
        print("Transformations: \(tranformations.count)")
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
