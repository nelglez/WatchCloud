//
//  StripeCart.swift
//  WatchCloud
//
//  Created by Bogdan Dovgopol on 28/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import Foundation

let StripeCart = _StripeCart()
final class _StripeCart {
    
    var cartItems = [Product]()
    private let stripeCreditCardCut = 0.029 // % fee
    private let flatFeeCents = 30
    var shippingFees = 0
    
    //variables for subtotal, processing fees, total
    
    var subtotal: Int {
        var amount = 0
        for item in cartItems {
            let pricePennies = Int(item.price * 100)
            amount += pricePennies
        }
        return amount
    }
    
    var processingFees: Int {
        if subtotal == 0 {
            return 0
        }
        let sub = Double(subtotal)
        let feesAndSub = Int(sub * stripeCreditCardCut) + flatFeeCents
        return feesAndSub
        
    }
    
    var total: Int {
        return subtotal + processingFees + shippingFees
    }
    
    func addItemToCart(item: Product) {
        cartItems.append(item)
    }
    
    func removeItemFromCart(item: Product) {
        if let index = cartItems.firstIndex(of: item) {
            cartItems.remove(at: index)
        }
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
    
}
