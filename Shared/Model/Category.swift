//
//  Category.swift
//  WatchCloud
//
//  Created by Bogdan Dovgopol on 11/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Category {
    var name: String
    var id: String
    var imgUrl: String
    var isActive: Bool = true
    var timestamp: Timestamp
    
    init(
        name: String,
        id: String,
        imgUrl: String,
        isActive: Bool = true,
        timestamp: Timestamp) {
        
        self.name = name
        self.id = id
        self.imgUrl = imgUrl
        self.isActive = isActive
        self.timestamp = timestamp
    }
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.imgUrl = data["imgUrl"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? true
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp()
    }
    
    static func modelToData(category: Category) -> [String: Any] {
        let data: [String: Any] = [
            "name" : category.name,
            "id" : category.id,
            "imgUrl" : category.imgUrl,
            "isActive" : category.isActive,
            "timestamp" : category.timestamp
        ]
        
        return data
    }
}
