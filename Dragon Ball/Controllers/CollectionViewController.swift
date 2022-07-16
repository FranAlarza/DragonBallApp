//
//  CollectionViewController.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 11/7/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController{
    
    var heroes: [Hero] = []
    
    @IBOutlet var heroCollection: UICollectionView!
    override func viewDidLoad() {
        
        let cellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "Cell")
        guard let token = LocalDataModel.getToken() else { return }
        let model = NetworkModel(token: token)
        model.getCharacter { [weak self] heroes, _ in
            self?.heroes = heroes
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return heroes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell()}
    
        cell.setData(model: heroes[indexPath.row])
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = DetailViewController()
        nextVC.setModel(model: heroes[indexPath.row])
        navigationController?.pushViewController(nextVC, animated: true)
    }
   
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width / 2) - 6
        return CGSize.init(width: width, height: 200)
    }
}
