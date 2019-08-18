//
//  ShoppingCartTableViewCell.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/16/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit
import Kingfisher//
// exit full scren
class ShoppingCartTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productHealth: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var dollarLabel: UILabel!
    
    @IBOutlet weak var Stepper: UIStepper!
    
    func setProduct(product: Product) {
        if let image = product.productImage {
            let url = URL(string: image)
            let processor = DownsamplingImageProcessor(size: productImageView.bounds.size)
            productImageView.kf.indicatorType = .activity
            productImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        }
        
        //Set image view with kingfisher
        
        productName.text = product.productName
        productPrice.text = ("$\(String(product.productPrice ?? 0))")
        productHealth.text = product.productHealth
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
