//
//  ProductCell.swift
//  WatchCloud
//
//  Created by Bogdan Dovgopol on 12/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
    }
    
    func configureCell(product: Product) {
        productName.text = product.name
        if let url = URL(string: product.imgUrl) {
            productImg.kf.setImage(with: url)
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let price = formatter.string(from: product.price as NSNumber) {
            productPrice.text = price
        }
    }

}
