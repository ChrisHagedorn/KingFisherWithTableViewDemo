//
//  ProductViewController.swift
//  
//
//  Created by Chris Hagedorn on 7/24/19.
//

import UIKit
import Kingfisher

class ProductViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productCatagory: UILabel!
    @IBOutlet weak var productHealth: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageUrl = product[row].productImage {
            let url = URL(string: imageUrl)
            let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(
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
        
        productName.text = product[row].productName
        productHealth.text = product[row].productHealth
        productPrice.text = String(product[row].productPrice!)

    }

}
// whereis it?
//should be under item in tab bar
