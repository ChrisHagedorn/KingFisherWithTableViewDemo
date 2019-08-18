//
//  ShoppingCartTableViewController.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/16/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit


class ShoppingCartTableViewController: UITableViewController {
    
    let product = cartId
    
     override func viewDidLoad() {
    tableView.delegate = self
       viewWillAppear(false)
    }
    
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartTableViewCell" ) as? TableViewCell {
            var products: Product
            products = product[indexPath.row]
            cell.setProduct(product: products)
            cell.layer.borderWidth = 10
            cell.layer.borderColor = #colorLiteral(red: 0.9600740075, green: 0.9602344632, blue: 0.9600527883, alpha: 1)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
}

