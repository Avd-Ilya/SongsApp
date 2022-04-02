//
//  SettingsViewController.swift
//  SongsApp
//
//  Created by Avdeev Ilya Aleksandrovich on 16.01.2022.
//  Copyright © 2022 Avdeev Ilya Aleksandrovich. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func logoutAction(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        }catch{
            print(error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil{
                self.showModalAuth()
            }
        }
    }
    
    func showModalAuth() {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
        self.navigationController?.pushViewController(newVC, animated: true)
    }
}
