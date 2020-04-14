//
//  ProductDetailFooter.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 1/20/20.
//  Copyright © 2020 Chris Hagedorn. All rights reserved.
//

import UIKit

class ProductDetailFooterCell: UICollectionViewCell {

        var data: Product?
        func setData(_ data: Product) {
            foodImageView.downloadImage(from: data.productImage)
            foodImageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            foodImageView.layer.borderWidth = 1
        }
        
    override func awakeFromNib() {
    }
        @IBOutlet weak var foodImageView: UIImageView!

}
