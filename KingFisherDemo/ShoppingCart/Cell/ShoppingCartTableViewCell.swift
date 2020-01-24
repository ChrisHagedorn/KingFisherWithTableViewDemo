//
//  ShoppingCartTableViewCell.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/16/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit
import Kingfisher//
import FirebaseDatabase
import FirebaseAuth

// exit full scren
class ShoppingCartTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productHealth: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var dollarLabel: UILabel!
    
    @IBOutlet weak var amountStepper: UIStepper!
    @IBOutlet weak var amountLabel: UILabel!
    weak var hostController: ShoppingCartViewController?
    
    var item: CartItem?
    
    func setProduct(item: CartItem) {
        self.item = item
        let amount = Double(item.amount ?? 0)
        amountStepper.value = amount
        amountLabel.text = String(Int(amount))
        
        guard let productId = item.productId else { return }
        
        if let product = item.product {
            setData(product: product)
        } else {
            Database.database().reference()
                .child("products")
                .child(productId)
                .observeSingleEvent(of: .value) { (snapshot) in
                    guard let rawData = snapshot.value as? AnyObject else { return }
                    let product = Product(rawData: rawData)
                    self.setData(product: product)
                    item.product = product
            }
        }
    }
    
    private func setData(product: Product) {
        productImageView.downloadImage(from: product.productImage)
        productName.text = product.productName
        productPrice.text = "$" + (String(product.productPrice ?? 0))
        productHealth.text = product.productHealth
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 10
        layer.borderColor = #colorLiteral(red: 0.9600740075, green: 0.9602344632, blue: 0.9600527883, alpha: 1)
        productImageView.makeRounded()
        productImageView.makeShadow()
        
        
    }
    
    @IBAction func amountChange(_ sender: Any) {
        amountLabel.text = String(Int(amountStepper.value))
        item?.amount = Int(amountStepper.value)
        hostController?.calculateTotal()
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(updateAmount), with: nil, afterDelay: 0.4)
    }
    
    @objc func updateAmount() {
        guard let myid = Auth.auth().currentUser?.uid else { return }
        guard let productId = item?.productId else { return }
        Database.database().reference()
            .child("cart")
            .child(myid)
            .child(productId).setValue(Int(amountStepper.value))
    }
}
