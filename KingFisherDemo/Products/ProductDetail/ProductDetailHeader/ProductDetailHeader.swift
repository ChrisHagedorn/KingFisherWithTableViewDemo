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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToCardButton: UIButton!
    
    var data: Product?
    
    func setData(data: Product) {
        productName.text = data.productName
        productHealth.text = data.productHealth
        productPrice.text = String(data.productPrice ?? 0)
        imageView.downloadImage(from: data.productImage)
        descriptionLabel.text =
                """
                Learning to code is incredibly rewarding but can also be difficult and frustrating. The strongest assets you can have as a student are a desire to build, a problem-solving mind, and persistence in the face of setbacks.

                The web development industry has a long history of successful developers with varying backgrounds, so people tend to care more about what you’ve actually built than how you got there.

                Read this comprehensive blog post from Happy Bear Software about the journey to getting hired as a brief introduction to what you will face ahead.
        """
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
        
    }
    
}

