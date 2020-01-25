//
//  ShoppingCartViewController.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/18/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class CartItem {
    var product: Product?
    var productId: String?
    var amount: Int?
    
    init(productId: String, amount: Int) {
        self.productId = productId
        self.amount = amount
    }
}

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    static func create() -> ShoppingCartViewController {
        return UIStoryboard(name: "ShoppingCartViewController", bundle: nil).instantiateInitialViewController() as! ShoppingCartViewController
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: ShoppingCartHeader!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var footerView: ShoppingCartFooter!
    
    var datasource = [CartItem]() {didSet {
        emptyLabel.isHidden = !datasource.isEmpty
        tableView.isHidden = datasource.isEmpty
        footerView.isHidden = datasource.isEmpty
        tableView.reloadData()
        
        calculateTotal()
        }
    }
    
    func calculateTotal() {
        
        guard let vcs = navigationController?.viewControllers else { return }
        var products = [Product]()
        for vc in vcs where vc is ProductsController {
            let productVC = vc as! ProductsController
            products = productVC.originalDatasource
            break
        }
        
        var dict = [String: Int]()
        for item in products {
            guard let id = item.productId, let price = item.productPrice else { continue }
            dict["product_\(id)"] = price
        }
        
        var sum = 0
        for item in datasource {
            guard let id = item.productId else  { continue }
            guard let price = dict[id] else { continue }
            guard let amount = item.amount else { return }
            sum += amount * price
        }
        
        footerView.setTotal(total: sum)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "ShoppingCartTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ShoppingCartTableViewCell")
        
        emptyLabel.isHidden = false
        tableView.isHidden = true
        footerView.isHidden = true
        
        getData()
    }
    
    func removeItem(item: CartItem) {
        guard let index = datasource.firstIndex(where: { return item.productId == $0.productId
        }) else { return }
        datasource.remove(at: index)
    }
    
    func getData() {
        guard let myId = Auth.auth().currentUser?.uid else { return }
        Database.database().reference()
            .child("cart")
            .child(myId)
            .observeSingleEvent(of: .value) { (snapshot) in
                guard let rawData = snapshot.value as? [String: Int] else { return }
                var carts = [CartItem]()
                for (productId, amount) in rawData {
                    let item = CartItem(productId: productId, amount: amount)
                    carts.append(item)
                }
                self.datasource = carts.sorted(by: { return ($0.productId ?? "") > ($1.productId ?? "") })
        }
        
        // cart -> your id ->
        // -> item id: amount
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        title = "Cart"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartTableViewCell" ) as! ShoppingCartTableViewCell
        let item = datasource[indexPath.row]
        cell.setProduct(item: item)
        cell.hostController = self
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
