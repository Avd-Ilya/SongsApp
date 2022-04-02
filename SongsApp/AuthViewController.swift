//
//  AuthViewController.swift
//  SongsApp
//
//  Created by Avdeev Ilya Aleksandrovich on 10.01.2022.
//  Copyright © 2022 Avdeev Ilya Aleksandrovich. All rights reserved.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {
    var singUp: Bool = true{
        willSet{
            if newValue{
                titleLabel.text = "Registration"
                enterButton.setTitle("Login", for: .normal)
            }else{
                titleLabel.text = "Login"
                enterButton.setTitle("Registration", for: .normal)
            }
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        passwordField.delegate = self
    }
    @IBAction func switchLogin(_ sender: Any) {
        singUp = !singUp
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Fill in all the fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showIncorrectDataAlert() {
        let alert = UIAlertController(title: "Error", message: "Incorrect data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showAuthErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "There is no such user", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let email = emailField.text!
        let password = passwordField.text!
        
        if(!email.isEmpty && !password.isEmpty) {
            if(singUp){
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if error == nil {
                        if let result = result {
                            print(result.user.uid)
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    } else {
                        self.showIncorrectDataAlert()
                    }
                }
            } else {
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    if error == nil {
                        if let result = result {
                            print(result.user.uid)
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    } else {
                        self.showAuthErrorAlert()
                    }
                }
            }
        }else{
            showAlert()
        }
        
        return true
    }
}
