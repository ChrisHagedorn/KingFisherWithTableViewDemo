//
//  ShoppingCartHeader.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/16/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit

class ShoppingCartHeader: UIView {
    
    @IBOutlet weak var cartLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
        
    }
}
