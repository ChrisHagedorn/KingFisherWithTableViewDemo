//
//  ShoppingCartFooter.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/16/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit

class ShoppingCartFooter: UIView {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    
    @IBAction func buttonClickled(_ sender: UIButton) {
        //Call checkout view controller create
        let vc = OrderInfoController.create()
       (superview?.next as? UIViewController)?.navigationController?.pushViewController(vc, animated: true)
        vc.itemsInCart = itemsInCart

    }
    func buttonHide(){
        nextButton.isHidden = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
        setPrice()
        
    }
    
    //Sets the productPrice label.
    func setPrice() {
        var sum: Int = 0
        if !itemsInCart.isEmpty{
            for index in 0...itemsInCart.count - 1 {
                sum += itemsInCart[index].productPrice ?? 0
                
            }
        }
        productPrice.text = String(sum)
    }
    
    
    
}
