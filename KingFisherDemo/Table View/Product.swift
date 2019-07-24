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
    var productName: String
    var productHealth: String
    var productPrice: Int
    var productImage: String
    
    init(productName: String, productHealth: String, productPrice: Int, productImage: String ){
        self.productName = productName
        self.productHealth = productHealth
        self.productPrice = productPrice
        self.productImage = productImage
        
    }
}
