//
//  ForgotPasswordVC.swift
//  WatchCloud
//
//  Created by Bogdan Dovgopol on 11/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordVC: UIViewController {

    // Outlets
    @IBOutlet weak var emailTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func resetPasswordClicked(_ sender: Any) {
        guard let email = emailTxt.text, email.isNotEmpty else {
            simpleAlert(title: "Error", message: "Please fill all fields.")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
