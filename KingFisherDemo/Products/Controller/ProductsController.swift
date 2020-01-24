//
//  TableViewController.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 7/23/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DataStore {
    static var products = [Product]()
}


class ProductsController: UITableViewController {
    @IBOutlet weak var headerView: ProductHeaderView!
    
    var ref: DatabaseReference!
    var databaseHandle:DatabaseHandle?
    var datasource = [Product]() { didSet {
        tableView.reloadData()
        DataStore.products = datasource
        }
    }
    var isSearching = false
    
    var originalDatasource = [Product]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "The Green Grocer"
        setupView()
        tableView.delegate = self
        tableView.dataSource = self
        headerView.delegate = self
        
        //Set database reference
        getData()
        
       
        
        
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
    
    func getProducts(completion: @escaping () -> Void) {
        Database.database().reference().child("products")
            .observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
                guard let rawData = snapshot.value as? [String: AnyObject] else { return }
                let products = Array(rawData.values).map({ return Product(rawData: $0) })
                self?.datasource = products
                self?.originalDatasource = products
                completion()
        })
    }
    
    
    func getFeatureProducts() {
        Database.database().reference()
            .child("featuredProducts").observeSingleEvent(of: .value) { (snapshot) in
                guard let rawData = snapshot.value as? [String: AnyObject] else { return }
                // convert datasource to array of id
                // run loop for feature products
                // if current item == datasource item
                let featured = Array(rawData.values).map({ return Product(rawData: $0) })
                for item in featured {
                    for product in self.datasource {
                        if item.productId == product.productId {
                            item.productImage = product.productImage
                        }
                    }
                }
                
                
                
                self.headerView.datasource = featured
        }
    }
    
    func getData() {
        getProducts(completion: {[weak self] in
            self?.getFeatureProducts()
        })
        
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
        
        //Shadow of cell.
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 5

        cell.layer.shadowOpacity = 0.40
        cell.layer.masksToBounds = false;
        cell.clipsToBounds = false;
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ProductDetailViewController.create()
        controller.data = datasource[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 325
    }
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
    

}


extension ProductsController: ProductHeaderDelegate {
    func didTapShoppingCart() {
        let controller = ShoppingCartViewController.create()
        navigationController?.pushViewController(controller, animated: true)
    }
}
