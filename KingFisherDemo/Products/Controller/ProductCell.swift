//
//  TableViewCell.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 7/23/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productHealth: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    
    func setProduct(product: Product) {
        //Set image view with kingfisher
        productImageView.downloadImage(from: product.productImage)
        productName.text = product.productName
        productPrice.text = ("$\(String(product.productPrice ?? 0))")
        productHealth.text = product.productHealth
    }
    override func awakeFromNib() {
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5

        self.layer.shadowOpacity = 0.40
        self.layer.masksToBounds = false;
        self.clipsToBounds = false;
    }
    
}
