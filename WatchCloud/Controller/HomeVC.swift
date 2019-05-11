//
//  ViewController.swift
//  WatchCloud
//
//  Created by Bogdan Dovgopol on 10/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //Variables
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let category = Category.init(name: "Apple Watch", id: "asdasda", imgUrl: "https://images.unsplash.com/photo-1434494878577-86c23bcb06b9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2550&q=80", isActive: true, timeStamp: Timestamp())
        let category1 = Category.init(name: "Apple Watch", id: "asdasda", imgUrl: "https://images.unsplash.com/photo-1434494878577-86c23bcb06b9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2550&q=80", isActive: true, timeStamp: Timestamp())
        categories.append(category)
        categories.append(category1)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Identifiers.CategoryCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.CategoryCell)
        
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    debugPrint(error)
                    Auth.auth().handleFireAuthError(error: error, vc: self)
                }
            }
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
//        if Auth.auth().currentUser == nil {
//            do{
//                try Auth.auth().signOut()
//                presentLoginController()
//            } catch {
//                debugPrint(error.localizedDescription)
//            }
//        }
    }
    
    private func presentLoginController(){
        let storyboard = UIStoryboard(name: Storyboard.AuthStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardId.Auth)
        present(controller, animated: false, completion: nil)
    }
}

extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.CategoryCell, for: indexPath) as? CategoryCell {
            cell.configureCell(category: categories[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        let cellWidth = (width - 60) / 2
        let cellHeight = cellWidth * 1.5
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
}

