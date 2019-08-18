//
//  ShoppingCartHeader.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/16/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit

protocol ShoppingCartHeaderDelegate {
    func didTapBackButton()
}

class ShoppingCartHeader: UIView {
    
    @IBOutlet weak var cartLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButtonPressed(_ sender: UIButton) {
        delegate?.didTapBackButton()
        print("Button pressed")
    }
    
    var delegate: ShoppingCartHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
        
    }
}
