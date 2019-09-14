//
//  FavoritesCell.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 9/9/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productHealth: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    func setProduct(product: Product){
        productImageView.downloadImage(from: product.productImage)
        productName.text = product.productName
        productPrice.text = String(product.productPrice ?? 0)
        productHealth.text = product.productHealth
    }
    

}
