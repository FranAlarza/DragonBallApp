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
        let charactersCollection = CharactersCollectionViewController()
        // Assign view controllers to tab bar
        self.setViewControllers([charactersTable, charactersCollection], animated: false)
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
