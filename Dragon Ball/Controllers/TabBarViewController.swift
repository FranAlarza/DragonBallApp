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
        setViewControllers([charactersTable, charactersCollection], animated: false)
        title = "Heroes"
        charactersTable.tabBarItem.title = "Table"
        charactersTable.tabBarItem.image = UIImage(systemName: "list.bullet")
        charactersCollection.tabBarItem.title = "Collection"
        charactersCollection.tabBarItem.image = UIImage(systemName: "tablecells")
        self.configureBarItems()
        
    }

}
