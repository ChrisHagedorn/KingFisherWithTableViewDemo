//
//  ProductDetailHeader.swift
//  
//
//  Created by Chris Hagedorn on 1/17/20.
//

import UIKit

class ProductDetailHeader: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productHealth: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    var data: Product?

    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
        setUpView()
        
    }
    

    func setUpView(){
        imageView.downloadImage(from: data?.productImage)
        productName.text = data?.productName
        productHealth.text = data?.productHealth
        productPrice.text = String(data?.productPrice ?? 0)

    }
    @IBAction func addToCart(_ sender: Any) {
        itemsInCart.append(data!)
        print("Added \(data!.productName ?? "Unknown") to Cart")

    }
}

