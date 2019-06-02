//
//  WishProductCell.swift
//  WatchCloud
//
//  Created by Bogdan Dovgopol on 19/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import UIKit
import Kingfisher

protocol WishProductCellDelegate: class {
    func addToCart(product: Product)
}

class WishProductCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var priceTxt: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    
    weak var delegate: WishProductCellDelegate?
    private var product: Product!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        selectionStyle = .none
        
    }
    
    func configureCell(product: Product, delegate: WishProductCellDelegate) {
        self.product = product
        self.delegate = delegate
        
        nameTxt.text = product.name
        if let url = URL(string: product.imgUrl) {
            productImg.kf.setImage(with: url)
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let price = formatter.string(from: product.price as NSNumber) {
            priceTxt.text = price
        }
    }
    
    @IBAction func addToCartClicked(_ sender: Any) {
        delegate?.addToCart(product: product)
    }
}
