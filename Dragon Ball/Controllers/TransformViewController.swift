//
//  TransformViewController.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 15/7/22.
//

import UIKit

class TransformViewController: UIViewController {

    
    @IBOutlet weak var transformationsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TransformationsCell", bundle: nil)
        transformationsTable.register(nib, forCellReuseIdentifier: "transform")
        view.addSubview(transformationsTable)
        transformationsTable.dataSource = self
        transformationsTable.delegate = self
    }

}

extension TransformViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = transformationsTable.dequeueReusableCell(withIdentifier: "transform", for: indexPath) as? TransformationsViewCell else { return UITableViewCell() }
        //cell.setData(model: getTransformations[indexPath.row])
        
        return cell
    }
    
    
    
    
}
