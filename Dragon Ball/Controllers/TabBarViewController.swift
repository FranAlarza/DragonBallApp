//
//  TabBarViewController.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 10/7/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create Instances viewcontrollers
        let charactersTable = CharactersTableViewController()
        let charactersCollection = CollectionViewController()
        // Assign view controllers to tab bar
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.setViewControllers([charactersTable, charactersCollection], animated: false)
        charactersTable.title = "Heroes Table"
        charactersTable.title = "Heroes Collection"
        charactersTable.tabBarItem.title = "Table"
        charactersTable.tabBarItem.image = UIImage(systemName: "list.bullet")
        charactersCollection.tabBarItem.title = "Collection"
        charactersCollection.tabBarItem.image = UIImage(systemName: "tablecells")
        
    }


}
