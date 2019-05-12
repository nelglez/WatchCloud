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
    
    init(data: [String: Any]) {
        self.id = data["id"] as? String ?? "Null"
        self.name = data["name"] as? String ?? "Null"
        self.price = data["price"] as? Double ?? 0
        self.productDescription = data["productDescription"] as? String ?? "Null"
        self.category = data["category"] as? String ?? "Null"
        self.imgUrl = data["imgUrl"] as? String ?? "Null"
        self.isActive = data["isActive"] as? Bool ?? true
        self.favorite = data["favorite"] as? Bool ?? false
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp()
    }
}
