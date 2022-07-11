//
//  LoginViewController.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 6/7/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func OnButtonTap(_ sender: Any) {
        let nextVC = TabBarViewController()
        navigationController?.pushViewController(nextVC, animated: true)
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
