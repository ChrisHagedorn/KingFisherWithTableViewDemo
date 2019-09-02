//
//  CategoriesDetailController.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/23/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CategoriesDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static func create() -> CategoriesDetailController {
        return UIStoryboard(name: "CategoriesDetail", bundle: nil).instantiateInitialViewController() as! CategoriesDetailController
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var productCountLabel: UILabel!
    
    var data: Category?
    var datasource = [Product]() { didSet {
        tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
    }

    
    func loadData() {
        guard let data = data else { return }
        coverImageView.downloadImage(from: "https://www.joyofbaking.com/images/facebook/whitesandwichbread.jpg")
        categoryNameLabel.text = data.name
        
        Database.database().reference()
            .child("masterSheet")
            .observeSingleEvent(of: .value) { (snapshot) in
                
                guard let rawData = snapshot.value as? [AnyObject] else { return }
                
                var products = [Product]()
                for item in rawData {
                    guard let itemArray = item as? [String: AnyObject] else { continue }
                    
                    let pro = Product()
                    if itemArray.count > 0 {
                        pro.productId = itemArray["id"] as? Int
                        
                    }
                    if itemArray.count > 1 {
                        pro.productName = itemArray["name"] as? String
                    }
                    
                    if itemArray.count > 2 {
                        pro.productHealth = itemArray["health"] as? String
                    }
                    
                    if itemArray.count > 3 {
                        pro.productPrice = itemArray["price"] as? Int
                    }
                    
                    if itemArray.count > 4 {
                        pro.productImage = itemArray["url"] as? String
                    }
                    
                    products.append(pro)
                }
                self.productCountLabel.text = "\(products.count) products"
                self.datasource = products
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        title = "Categories"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesDetailCell" ) as! CategoriesDetailCell
        let product = datasource[indexPath.row]
        cell.setProduct(product: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 312
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ProductDetailViewController.create()
        controller.data = datasource[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}
