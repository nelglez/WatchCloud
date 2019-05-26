//
//  Product.swift
//  WatchCloud
//
//  Created by Bogdan Dovgopol on 12/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Product {
    var id: String
    var name: String
    var price: Double
    var productDescription: String
    var category: String
    var imgUrl: String
    var isActive: Bool = true
    var favorite: Bool
    var timestamp: Timestamp
    
    init(
        id: String,
        name: String,
        price: Double,
        productDescription: String,
        category: String,
        imgUrl: String,
        isActive: Bool = true,
        favorite: Bool = false,
        timestamp: Timestamp) {
        
        self.id = id
        self.name = name
        self.price = price
        self.productDescription = productDescription
        self.category = category
        self.imgUrl = imgUrl
        self.isActive = isActive
        self.favorite = favorite
        self.timestamp = timestamp
    }
    
    init(data: [String: Any]) {
        self.id = data["id"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.price = data["price"] as? Double ?? 0
        self.productDescription = data["productDescription"] as? String ?? ""
        self.category = data["category"] as? String ?? ""
        self.imgUrl = data["imgUrl"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? true
        self.favorite = data["favorite"] as? Bool ?? false
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp()
    }
    
    static func modelToData(product: Product) -> [String: Any] {
        let data: [String: Any] = [
            "id" : product.id,
            "name" : product.name,
            "price" : product.price,
            "productDescription" : product.productDescription,
            "category" : product.category,
            "imgUrl" : product.imgUrl,
            "isActive" : product.isActive,
            "favorite" : product.favorite,
            "timestamp" : product.timestamp
        ]
        
        return data
    }
}

extension Product : Equatable {
    
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
