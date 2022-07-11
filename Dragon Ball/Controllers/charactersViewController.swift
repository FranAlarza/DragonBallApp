//
//  charactersViewController.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 7/7/22.
//

import UIKit

class charactersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var charactersTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersTable.dataSource = self
        charactersTable.delegate = self
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        charactersTable.register(nib, forCellReuseIdentifier: "CharacterViewCell")
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = charactersTable.dequeueReusableCell(withIdentifier: "CharacterViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        cell.setDataCell(image: "", name: "", description: "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
