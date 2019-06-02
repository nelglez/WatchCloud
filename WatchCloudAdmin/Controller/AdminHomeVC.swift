//
//  AdminHomeVC.swift
//  WatchCloudAdmin
//
//  Created by Bogdan Dovgopol on 16/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import UIKit
import FirebaseAuth

class AdminHomeVC: HomeVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        let addCategoryBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "add"), style: .plain, target: self, action: #selector(addCategory))
        navigationItem.rightBarButtonItem = addCategoryBtn
    }
    
    @objc func addCategory() {
        performSegue(withIdentifier: Segues.ToAddCategory, sender: self)
    }

}
