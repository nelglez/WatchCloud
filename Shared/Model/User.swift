//
//  User.swift
//  WatchCloudAdmin
//
//  Created by Bogdan Dovgopol on 18/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import Foundation

struct User {
    var id: String
    var email: String
    var stripeId: String
    
    init(id: String = "",
         email: String = "",
         stripeId: String = "") {
        
        self.id = id
        self.email = email
        self.stripeId = stripeId
    }
    
    init(data: [String: Any]) {
        id = data["id"] as? String ?? ""
        email = data["email"] as? String ?? ""
        stripeId = data["stripeId"] as? String ?? ""
    }
    
    static func modelToData(user: User) -> [String: Any] {
        let data : [String: Any] = [
            "id" : user.id,
            "email" : user.email,
            "stripeId" : user.stripeId
        ]
        
        return data
    }
}
