//
//  WishlistVC.swift
//  WatchCloud
//
//  Created by Bogdan Dovgopol on 19/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import UIKit
import FirebaseFirestore

class WishlistVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var products = [Product]()
    var listener: ListenerRegistration!
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        navBarSettings()
        configureTableView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getFavorites()
    }
    
    func navBarSettings() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationItem.backBarButtonItem = backButton
        self.navigationItem.title = "Wish List"
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Identifiers.WishProductCell, bundle: nil), forCellReuseIdentifier: Identifiers.WishProductCell)
        
        //ui
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
    }
    
    func getFavorites() {
        
        listener = db.collection("users").document(UserService.user.id).collection("favorites").addSnapshotListener({ (snap, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            snap?.documentChanges.forEach({ (change) in
                
                let data = change.document.data()
                let product = Product.init(data: data)
                
                switch change.type {
                case .added:
                    self.onDocumentAdded(change: change, product: product)
                case .modified:
                    self.onDocumentModified(change: change, product: product)
                case .removed:
                    self.onDocumentRemoved(change: change)
                }
                
            })
            
        })
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //stop listening to updates = save quota
        listener.remove()
        products.removeAll()
        tableView.reloadData()
    }
}

extension WishlistVC: UITableViewDelegate, UITableViewDataSource {
    
    func onDocumentAdded(change: DocumentChange, product: Product) {
        let newIndex = Int(change.newIndex)
        products.insert(product, at: newIndex)
        tableView.insertRows(at: [IndexPath(item: newIndex, section: 0)], with: .automatic)
    }
    
    func onDocumentModified(change: DocumentChange, product: Product) {
        if change.newIndex == change.oldIndex {
            //item changed but remained in the same position
            let index = Int(change.newIndex)
            products[index] = product
            
            tableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .automatic)
            
        } else {
            //item changed and changed position
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            products.remove(at: oldIndex)
            products.insert(product, at: newIndex)
            
            tableView.moveRow(at: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newIndex, section: 0))
        }
    }
    
    func onDocumentRemoved(change: DocumentChange) {
        let oldIndex = Int(change.oldIndex)
        products.remove(at: oldIndex)
        
        tableView.deleteRows(at: [IndexPath(item: oldIndex, section: 0)], with: .automatic)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.WishProductCell, for: indexPath) as? WishProductCell {
            cell.configureCell(product: products[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.width / 3
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            UserService.favoriteSelected(product: products[indexPath.row])
        }
    }
}
