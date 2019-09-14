//
//  Customer.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 9/13/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import Foundation
import FirebaseAuth

class Customer {
    var userId: String?
    var idToken: String?
    var fullName: String?
    var givenName: String?
    var familyName: String?
    var email: String?
   
    init(userId: String, idToken: String, fullName: String, givenName: String, familyName: String, email: String) {
        self.userId = userId
        self.idToken = idToken
        self.fullName = fullName
        self.givenName = givenName
        self.familyName = familyName
        self.email = email
    }
    
    init() {
        
    }

    
}


func getProductIdKey(id: Int) -> String {
    return "product_\(id)"
}
