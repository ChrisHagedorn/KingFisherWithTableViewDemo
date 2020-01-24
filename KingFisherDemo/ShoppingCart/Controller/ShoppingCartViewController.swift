//
//  ShoppingCartViewController.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/18/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    static func create() -> ShoppingCartViewController {
        return UIStoryboard(name: "ShoppingCartViewController", bundle: nil).instantiateInitialViewController() as! ShoppingCartViewController
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: ShoppingCartHeader!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var footerView: ShoppingCartFooter!
    
    var product = itemsInCart {didSet {
        emptyLabel.isHidden = !product.isEmpty
        tableView.isHidden = product.isEmpty
        footerView.isHidden = product.isEmpty
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if product.isEmpty {
            emptyLabel.isHidden = false
            tableView.isHidden = true
            footerView.isHidden = true
        }else{
            tableView.delegate = self
            tableView.dataSource = self
            let nib = UINib(nibName: "ShoppingCartTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "ShoppingCartTableViewCell")
        }


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        title = "Cart"


    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartTableViewCell" ) as! ShoppingCartTableViewCell
        var products: Product
        products = product[indexPath.row]
        cell.setProduct(product: products)
        cell.layer.borderWidth = 10
        cell.layer.borderColor = #colorLiteral(red: 0.9600740075, green: 0.9602344632, blue: 0.9600527883, alpha: 1)
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
    
}

//Perform Cart back button segue
//Fix Cart Table View
//Product Details XIB: Just get info
//
