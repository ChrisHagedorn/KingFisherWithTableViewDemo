//
//  CategoriesDetailCell.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/22/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit
import Kingfisher

class CategoriesDetailCell: UITableViewCell {


    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var health: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var category: UILabel!

    func setProduct(product: Product) {
        //Set image view with kingfisher
        productImageView.downloadImage(from: product.productImage)
        name.text = product.productName
        price.text = (String(product.productPrice ?? 0))
        health.text = product.productHealth
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 10
        layer.borderColor = #colorLiteral(red: 0.9600740075, green: 0.9602344632, blue: 0.9600527883, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
