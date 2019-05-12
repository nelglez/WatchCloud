//
//  ProductCell.swift
//  WatchCloud
//
//  Created by Bogdan Dovgopol on 12/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
    }
    
    func configureCell(product: Product) {
        productName.text = product.name
        debugPrint(productName.text)
        price.text = "$\(product.price)"
        if let url = URL(string: product.imgUrl) {
            productImg.kf.setImage(with: url)
        }
    }
    
}
