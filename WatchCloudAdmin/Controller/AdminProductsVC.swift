//
//  AdminProductsVC.swift
//  WatchCloudAdmin
//
//  Created by Bogdan Dovgopol on 16/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import UIKit

class AdminProductsVC: ProductsVC {
    
    var productToEdit: Product?

    override func viewDidLoad() {
        super.viewDidLoad()

        let addProductBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "add"), style: .plain, target: self, action: #selector(addProduct))
        let editCategoryBtn = UIBarButtonItem(title: "Edit Category", style: .plain, target: self, action: #selector(editCategory))
        navigationItem.setRightBarButtonItems([addProductBtn, editCategoryBtn], animated: false)
    }
    
    @objc func addProduct() {
        productToEdit = nil
        performSegue(withIdentifier: Segues.ToAddEditProduct, sender: self)
    }

    @objc func editCategory() {
        performSegue(withIdentifier: Segues.ToEditCategory, sender: self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //editing product
        productToEdit = products[indexPath.row]
        performSegue(withIdentifier: Segues.ToAddEditProduct, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.ToAddEditProduct {
            if let destination = segue.destination as? AddEditProductVC {
                destination.selectedCategory = category
                destination.productToEdit = productToEdit
            }
        } else if segue.identifier == Segues.ToEditCategory {
            if let destination = segue.destination as? AddEditCategoryVC {
                destination.categoryToEdit = category
            }
        }
        
    }
}
