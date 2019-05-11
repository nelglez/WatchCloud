//
//  LoginVC.swift
//  WatchCloud
//
//  Created by Bogdan Dovgopol on 10/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        
        guard let email = emailTxt.text, email.isNotEmpty,
            let password = passwordTxt.text, password.isNotEmpty else {
                simpleAlert(title: "Error", message: "Please fill out all fields.")
                return
        }
        
        activityIndicator.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if let error = error {
                debugPrint(error.localizedDescription)
                Auth.auth().handleFireAuthError(error: error, vc: self!)
                self?.activityIndicator.stopAnimating()
                return
            }
            self?.activityIndicator.stopAnimating()
            self?.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        let vc = ForgotPasswordVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func guestClicked(_ sender: Any) {
    }

}
