//
//  TableViewController.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 7/23/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ProductsController: UITableViewController {
    @IBOutlet weak var headerView: ProductHeaderView!
    @IBAction func sort(_ sender: UIButton) {
        
    }
    
    var ref: DatabaseReference!
    var databaseHandle:DatabaseHandle?
    var datasource = [Product]() { didSet {
            tableView.reloadData()
        }
    }
    var isSearching = false

    var originalDatasource = [Product]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupView()
        tableView.delegate = self
        tableView.dataSource = self
        headerView.delegate = self
        //Set database reference
        ref = Database.database().reference()
        databaseHandle = ref.child("masterSheet").observe(.value) { (snapshot) in
          
            
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
            self.datasource = products
            self.originalDatasource = products
            self.getData()
        }
    }
    
    func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .done, target: self, action: #selector(showSortMenu))
        headerView.searchBar.delegate = self
    }
    
    @objc func showSortMenu() {
        let controller = UIAlertController(title: "Sorting", message: "Select your sort criteria", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Name", style: .default, handler: { _ in
                self.datasource.sort(by: { ($0.productName ?? "") < ($1.productName ?? "") })
        }))
        
        controller.addAction(UIAlertAction(title: "Price", style: .default, handler: { _ in
            self.datasource.sort(by: { ($0.productPrice ?? 0) < ($1.productPrice ?? 0) })
        }))
        
        controller.addAction(UIAlertAction(title: "Health", style: .default, handler: { _ in
            self.datasource.sort(by: { ($0.productHealth ?? "") < ($1.productHealth ?? "") })
        }))
        
        
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(controller, animated: true)
    }
    
    func getData() {
        headerView.datasource = [
            Product(productId: 1123123, productName: "", productHealth: "", productPrice: 0, productImage: "https://gousto.gurucloud.co.uk/wp-content/uploads/2018/01/hero-image-1.jpg"),
            Product(productId: 1123123, productName: "", productHealth: "", productPrice: 0, productImage: "https://gousto.gurucloud.co.uk/wp-content/uploads/2018/01/hero-image-1.jpg"),
           Product(productId: 1123123, productName: "", productHealth: "", productPrice: 0, productImage: "https://gousto.gurucloud.co.uk/wp-content/uploads/2018/01/hero-image-1.jpg"),
           Product(productId: 1123123, productName: "", productHealth: "", productPrice: 0, productImage: "https://gousto.gurucloud.co.uk/wp-content/uploads/2018/01/hero-image-1.jpg"),
           Product(productId: 1123123, productName: "", productHealth: "", productPrice: 0, productImage: "https://gousto.gurucloud.co.uk/wp-content/uploads/2018/01/hero-image-1.jpg"),
           Product(productId: 1123123, productName: "", productHealth: "", productPrice: 0, productImage: "https://gousto.gurucloud.co.uk/wp-content/uploads/2018/01/hero-image-1.jpg"),
           Product(productId: 1123123, productName: "", productHealth: "", productPrice: 0, productImage: "https://gousto.gurucloud.co.uk/wp-content/uploads/2018/01/hero-image-1.jpg"),
           Product(productId: 1123123, productName: "", productHealth: "", productPrice: 0, productImage: "https://gousto.gurucloud.co.uk/wp-content/uploads/2018/01/hero-image-1.jpg"),
           Product(productId: 1123123, productName: "", productHealth: "", productPrice: 0, productImage: "https://gousto.gurucloud.co.uk/wp-content/uploads/2018/01/hero-image-1.jpg"),
        ]
    }
}

extension ProductsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(doSearch), with: searchText, afterDelay: 0.35)
    }
    
    @objc func doSearch(searchText: String) {
        if searchText.isEmpty {
            datasource = originalDatasource
            return
        }
        
        let filteredData = originalDatasource.filter({
            return $0.productHealth?.lowercased().contains(searchText.lowercased()) == true ||
                $0.productName?.lowercased().contains(searchText.lowercased()) == true
        })
        
        
        datasource = filteredData
    }
}


extension ProductsController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell" ) as! ProductCell
        let product = datasource[indexPath.row]
        cell.setProduct(product: product)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ProductDetailViewController.create()
        controller.data = datasource[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 312
    }
}


extension ProductsController: ProductHeaderDelegate {
    func didTapShoppingCart() {
        let controller = ShoppingCartViewController.create()
        navigationController?.pushViewController(controller, animated: true)
    }
}
