//
//  TransformViewController.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 15/7/22.
//

import UIKit

class TransformViewController: UIViewController {

    
    @IBOutlet weak var transformationsTable: UITableView!
    
    var transformations: [Transformations] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TransformationsCell", bundle: nil)
        transformationsTable.register(nib, forCellReuseIdentifier: "transform")
        view.addSubview(transformationsTable)
        transformationsTable.dataSource = self
        transformationsTable.delegate = self
        self.title = "Transformations"
        
        self.transformationsTable.reloadData()
    }

}

extension TransformViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = transformationsTable.dequeueReusableCell(withIdentifier: "transform", for: indexPath) as? TransformationsViewCell else { return UITableViewCell() }
        cell.setData(model: transformations[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = TransformationsDetailController()
        nextVC.setData(model: transformations[indexPath.row])
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
