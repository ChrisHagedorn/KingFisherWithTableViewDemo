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
        foodImageView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        foodImageView.layer.borderWidth = 1
    }

}
