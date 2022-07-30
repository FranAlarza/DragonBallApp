//
//  DetailViewController.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 11/7/22.
//

import UIKit

private enum Constants {
    static let normalImageHeight = 250.0
}

class DetailViewController: UIViewController {
    
    var tranformations: [Transformations] = []
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var transformationsButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    private var hero: Hero?
    private var transformations: Transformations?
    
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
        self.configureBarItems()
        
        scrollView.delegate = self
        
        guard let token = LocalDataModel.getToken() else { return }
        // Network Call
        let networkModel = NetworkModel(token: token)
        networkModel.getTransformations(id: hero.id) { [weak self] transform, error in
            DispatchQueue.main.async {
                self?.tranformations = transform
                if self?.tranformations.count ?? 0 > 0 {
                    self?.transformationsButton.alpha = 1
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
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let correctedOffset = scrollView.contentOffset.y + 92.0
        imageHeight.constant = Constants.normalImageHeight - correctedOffset
    }
}
