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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if LocalDataModel.getToken() != nil {
            let nextVC = TabBarViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    @IBAction func OnButtonTap(_ sender: Any) {
        let model = NetworkModel()
        let userNameText = usernameLabel.text ?? ""
        let passwordText = passwordLabel.text ?? ""
        self.loginButton.isEnabled = false
        self.activityIndicator.startAnimating()
        
        guard !userNameText.isEmpty, !passwordText.isEmpty else {
            activityIndicator.stopAnimating()
            self.loginButton.isEnabled = true
            return
        }
        
        
        model.login(user: userNameText, password: passwordText) { [weak self] token, _ in
            
            DispatchQueue.main.async {
                self?.loginButton.isEnabled = true
                self?.activityIndicator.stopAnimating()
                guard let token = token,
                      !token.isEmpty else {
                    return
                }
                
                LocalDataModel.saveToken(token: token)
                let nextVC = TabBarViewController()
                self?.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
        
        
    }
    
}

