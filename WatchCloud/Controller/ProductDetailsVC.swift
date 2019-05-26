//
//  ProductDetailsVC.swift
//  WatchCloud
//
//  Created by Bogdan Dovgopol on 13/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {

    @IBOutlet weak var productNameTxt: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productPriceTxt: UILabel!
    @IBOutlet weak var productDescriptionTxt: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    //Variables
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        navBarSettings()
        setProductDetails()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        setProductDetails()
    }
    
    func navBarSettings() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationItem.backBarButtonItem = backButton
        self.navigationItem.title = "Product Details"
    }
    
    func setProductDetails() {
        productNameTxt.text = product.name
        if let url = URL(string: product.imgUrl){
            productImg.kf.setImage(with: url)
        }
        productDescriptionTxt.text = product.productDescription
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let price = formatter.string(from: product.price as NSNumber) {
            productPriceTxt.text = price
        }
        
        changeFavoriteIcon()
    }
    
    func changeFavoriteIcon() {
        if UserService.favorites.contains(product) {
            favoriteBtn.setImage(UIImage(named: AppImages.FilledHearth), for: .normal)
        } else {
            favoriteBtn.setImage(UIImage(named: AppImages.EmptyHearth), for: .normal)
        }
    }
    
    @IBAction func addToCartClicked(_ sender: Any) {
    }
    
    @IBAction func favoriteClicked(_ sender: Any) {
        UserService.favoriteSelected(product: product)
        changeFavoriteIcon()
    }

    
}
