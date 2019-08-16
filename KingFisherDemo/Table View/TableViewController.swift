//
//  TableViewController.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 7/23/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit
import FirebaseDatabase



var product: [Product] = []
var row = 0


class TableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var headerView: ProductHeaderView!
    @IBAction func sort(_ sender: UIButton) {
        isSorted = true
        
    }
    @IBAction func edit(_ sender: Any) {
        tableView.isEditing = !tableView.isEditing
    }
    var ref: DatabaseReference!
    var databaseHandle:DatabaseHandle?
    var dataArray = [Product]()
    
    var isSearching = false
    var isSorted = false
    var filteredData = [Product]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        headerView.delegate = self
        //Set database reference
        ref = Database.database().reference()
        databaseHandle = ref.child("masterSheet").observe(.value) { (snapshot) in
          
            
            guard let rawData = snapshot.value as? [AnyObject] else { return }
            
            
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
                
                
                product.append(pro)
            }
            
            self.tableView.reloadData()
            
            self.getData()
            
            
        }
    }
    
    func getData() {
        // favourite: save to firebase not in useraccount
        // new node: favourite, save your accountId and food id
        // favourite/
        //      accountId
        //          foodId: 1
        //          food id: 1
        // get data from firebase
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
    
    
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = product[sourceIndexPath.row]
        product.remove(at: sourceIndexPath.row)
        product.insert(item, at: destinationIndexPath.row)
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredData.count
        }
        
        return product.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell" ) as? TableViewCell {
            var products: Product
            
            if isSearching{
                products = filteredData[indexPath.row]
                
            }else{
                products = product[indexPath.row]
            }
            
            //Sorts by product price
            if isSorted{
                product.sort(by: { $0.productPrice! < $1.productPrice! })
                products = product[indexPath.row]
                
          //      let sortedArray = product.sort(by: { $0.productPrice! < $1.productPrice! })
         //       products = sortedArray[indexPath.row]
                //TODO: Upon clicking the sort function, have the row identifier match up fo product view controller
            }else{
                products = product[indexPath.row]
            }
            
            //Sorts by alphabetical:
            //product.sorted(by: { $0.productName.lowercased()! < $1.productName.lowercased() })
            
            //Sorts by Type:
            //product.sorted(by: { $0.productHealth.lowercased()! < $1.productHealth.lowercased() })
 
            
            cell.setProduct(product: products)
            cell.layer.borderWidth = 10
            cell.layer.borderColor = #colorLiteral(red: 0.9600740075, green: 0.9602344632, blue: 0.9600527883, alpha: 1)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }else{
            isSearching = true
            filteredData = product.filter({
                
                if $0.productName!.lowercased().contains(searchBar.text!.lowercased())
                    || $0.productHealth!.lowercased().contains(searchBar.text!.lowercased()) == true {
                    return true
                }else{
                    return false
                    //TODO: 


                }
            })
            tableView.reloadData()
        }
    }
    
    
}

extension TableViewController: ProductHeaderDelegate {
    func didTapShoppingCart() {
        print("Cart Button 1 Clicked")
        performSegue(withIdentifier: "shoppingCart", sender: self)
        print("Cart Button Clicked")
    }
}
