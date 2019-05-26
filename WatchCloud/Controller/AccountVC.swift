//
//  AccountVC.swift
//  WatchCloud
//
//  Created by Bogdan Dovgopol on 11/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import UIKit
import Firebase
import Crashlytics
import Fabric

class AccountVC: UIViewController {

    //Outlets
    @IBOutlet weak var loginOutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if let user = Auth.auth().currentUser, !user.isAnonymous {
//            //we are logged in
//            if UserService.userListener == nil {
//                UserService.getCurrentUser()
//            }
//        } else {
//            presentLoginController()
//        }
    }
    
    func navBarSettings() {
        self.navigationItem.title = "Account"
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
        guard let user = Auth.auth().currentUser else { return }
        if user.isAnonymous {
            presentLoginController()
        } else {
            do {
                try Auth.auth().signOut()
                Auth.auth().signInAnonymously { (result, error) in
                    if let error = error {
                        debugPrint(error)
                        Auth.auth().handleFireAuthError(error: error, vc: self)
                    }
                    self.presentLoginController()
                }
            } catch {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
            }
        }
        
    }
    
    private func presentLoginController(){
        let storyboard = UIStoryboard(name: Storyboard.AuthStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardId.Auth)
        present(controller, animated: false, completion: nil)
    }
    

}
