//
//  ProductViewController.swift
//  
//
//  Created by Chris Hagedorn on 7/24/19.
//

import UIKit
import Kingfisher

var cartId: [Product] = []

class ProductDetailViewController: UIViewController {
    static func create() -> ProductDetailViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
    }
    
    var data: Product?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productCatagory: UILabel!
    @IBOutlet weak var productHealth: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    @IBAction func addToCart(_ sender: Any) {
        //cartId.append(product[row])
        //print("Added \(product[row].productName ?? "fred") to Cart")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        imageView.downloadImage(from: data?.productImage)
        productName.text = data?.productName
        productHealth.text = data?.productHealth
        productPrice.text = String(data?.productPrice ?? 0)
    }

}
