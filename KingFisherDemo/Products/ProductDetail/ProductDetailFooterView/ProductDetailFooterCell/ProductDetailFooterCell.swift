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
            self.data = data
            foodImageView.downloadImage(from: data.productImage)
        }
        
        @IBOutlet weak var foodImageView: UIImageView!

}
