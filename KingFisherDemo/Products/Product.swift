//
//  Product.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 7/23/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import Foundation
import UIKit

class Product {
    var productId: Int?
    var productName: String?
    var productHealth: String?
    var productPrice: Int?
    var productImage: String?
    
    init(productId: Int, productName: String, productHealth: String, productPrice: Int, productImage: String ){
        self.productId = productId
        self.productName = productName
        self.productHealth = productHealth
        self.productPrice = productPrice
        self.productImage = productImage
        
    }
    
    init() {
        // empty one to parse when you don't know exactly data
        // should use optional instead of data.
    }
    
}

