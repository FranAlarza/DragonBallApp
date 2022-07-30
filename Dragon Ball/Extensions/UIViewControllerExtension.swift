//
//  UIViewControllerExtension.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 27/7/22.
//

import Foundation
import UIKit

extension UIViewController {
    func configureBarItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(actionBarItem))
        navigationItem.rightBarButtonItem?.tintColor = .red
        
    }
    
    @objc func actionBarItem() {
        LocalDataModel.deleteToken()
        navigationController?.setViewControllers([LoginViewController()], animated: true)
    }
}
