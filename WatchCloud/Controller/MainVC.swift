//
//  ViewController.swift
//  WatchCloud
//
//  Created by Bogdan Dovgopol on 10/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        loadRightController()
    }
    
    private func loadRightController(){
        let storyboard = UIStoryboard(name: Storyboard.AuthStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardId.AuthVC)
        present(controller, animated: false, completion: nil)
    }
}

