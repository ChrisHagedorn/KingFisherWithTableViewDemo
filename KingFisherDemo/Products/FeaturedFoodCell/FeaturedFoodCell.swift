//
//  FeaturedFoodCell.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/12/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit

class FeaturedFoodCell: UICollectionViewCell {

    var data: Product?
    func setData(_ data: Product) {
        self.data = data
        foodImageView.downloadImage(from: data.productImage)
    }
    
    @IBOutlet weak var foodImageView: UIImageView!
    
    override func awakeFromNib() {
        foodImageView.makeShadow()
    }

}
