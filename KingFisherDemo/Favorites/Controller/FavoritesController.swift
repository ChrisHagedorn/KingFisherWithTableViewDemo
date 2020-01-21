//
//  FavoritesController.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 9/9/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class FavoritesController: UITableViewController {
    
    static func create() -> FavoritesController {
        return UIStoryboard(name: "Favorites", bundle: nil).instantiateInitialViewController() as! FavoritesController
    }
    
    var datasource = [Product]() { didSet {
        tableView.reloadData()
        emptyLabel.isHidden = !datasource.isEmpty
        }
        
    }
    @IBOutlet weak var emptyLabel: UILabel!
    
    
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle!
    let userKey = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        title = "Favorites"
        
        let nib = UINib(nibName: "FavoritesCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FavoritesCell")
        
        super.viewDidLoad()
        
        emptyLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        let productSource = DataStore.products
        ref = Database.database().reference()
        guard let userId = Auth.auth().currentUser?.uid else { return }
        ref.child("favourites").child(userId).observe(.value)
        { (snapshot) in
            
            guard let rawData = snapshot.value as? [String: AnyObject] else { return }
            let favoriteKeys = rawData.compactMap({
                return $0.value as! Bool ? $0.key : nil
            })
            let products = productSource.filter({ item in
                let itemId = "product_\(item.productId ?? 0)"
                if favoriteKeys.contains(itemId) {
                    return true
                }
                
                return false
            })
            self.datasource = products
        }
        //MARK: If table is empty put a title, you have no favorites.
    }

}



extension FavoritesController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell" ) as! FavoritesCell
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
