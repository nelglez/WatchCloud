//
//  CartItemCell.swift
//  WatchCloud
//
//  Created by Bogdan Dovgopol on 28/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import UIKit

class CartItemCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var priceTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(product: Product) {
        nameTxt.text = product.name
        if let url = URL(string: product.imgUrl) {
            itemImg.kf.setImage(with: url)
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let price = formatter.string(from: product.price as NSNumber) {
            priceTxt.text = price
        }
    }
    
}
