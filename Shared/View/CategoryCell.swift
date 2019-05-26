//
//  CategoryCell.swift
//  WatchCloud
//
//  Created by Bogdan Dovgopol on 11/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {
    //Outlets
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let margins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
//        contentView.frame = contentView.frame.inset(by: margins)
//    }
    
    func configureCell(category: Category) {
        categoryName.text = category.name
        if let url = URL(string: category.imgUrl) {
            categoryImg.kf.setImage(with: url)
        }
        
    }

}
