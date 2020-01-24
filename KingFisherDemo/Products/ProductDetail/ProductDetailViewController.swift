//
//  ProductViewController.swift
//  
//
//  Created by Chris Hagedorn on 7/24/19.
//

import UIKit
import Kingfisher
import Firebase
import FirebaseDatabase

var itemsInCart: [Product] = []

class ProductDetailViewController: UIViewController {
    static func create() -> ProductDetailViewController {
        return UIStoryboard(name: "ProductDetail", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
    }
    
    
    @IBOutlet weak var headerView: ProductDetailHeader!
    @IBOutlet weak var footerView: ProductDetailFooterView!
    
    var data: Product?
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    var dataLength: Int?
    var sourceFavorites: [Product] = []
    var isFavorite = false { didSet {
        updateFavoriteIcon()
        }}
    
    
    var favoriteButton = UIButton()
    
    
    @IBAction func addToFavorites() {
        isFavorite = !isFavorite
        ref = Database.database().reference().child("favourites")
        guard let userKey = Auth.auth().currentUser?.uid else {return}
        guard let productId = data?.productId else { return }
        ref.child(userKey).child(getProductIdKey(id: productId)).setValue(isFavorite)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.setData(data: data!)
        setupView()
        getData()
        getSimilarProduct()
    }
    
    
    func getData() {
        ref = Database.database().reference().child("favourites")
        guard let userKey = Auth.auth().currentUser?.uid else {return}
        guard let productId = data?.productId else { return }
        ref.child(userKey).child(getProductIdKey(id: productId)).observeSingleEvent(of: .value, with: { snapshot in
            let isFavorite = snapshot.value as? Bool ?? false
            self.isFavorite = isFavorite
        })
    }
    
    func updateFavoriteIcon() {
        if isFavorite {
            favoriteButton.backgroundColor = .red
            
        } else {
            favoriteButton.backgroundColor = .blue
        }
    }
    
    func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
        favoriteButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        headerView.addToCardButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
    }
    
    @objc func addToCart() {
        guard let myid = Auth.auth().currentUser?.uid else { return }
        guard let productId = data?.productId else { return }
        // cart: product 1 (2), 2 (1), 3 (4)
        Database.database().reference()
            .child("cart")
            .child(myid)
            .child("product_" + String(productId))
            .observeSingleEvent(of: .value) { (snapshot) in
                var count = snapshot.value as? Int ?? 0
                count += 1
                Database.database().reference()
                    .child("cart")
                    .child(myid)
                    .child("product_" + String(productId)).setValue(count)
                
        }
    }
    
    func getSimilarProduct() {
        Database.database().reference().child("products")
            .observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
                guard let rawData = snapshot.value as? [String: AnyObject] else { return }
                let products = Array(rawData.values)
                    .map({ return Product(rawData: $0) })
                    .filter({ return $0.productId != self?.data?.productId })
                
                var result = products.filter({ return $0.productHealth == self?.data?.productHealth })
                if result.count >= 4 {
                    result = Array(result[0...3])
                } else {
                    let restCount = 4 - result.count
                    let resultIds = result.compactMap({ return $0.productId })
                    
                    var rest = products.filter({ return resultIds.contains($0.productId!) == false })
                    rest = Array(products[0..<restCount])
                    
                    print(rest.map({ return $0.productId }))
                    
                    result.append(contentsOf: rest)
                }
                self?.footerView.datasource = result
            })
    }
    
    
    //    func getFavorites(){
    //        ref = Database.database().reference()
    //        guard let userKey = Auth.auth().currentUser?.uid else {return}
    //        databaseHandle = ref.child("favourites").child(userKey).observe(.value){
    //            (snapshot) in
    //
    //            guard let rawData = snapshot.value as? [AnyObject] else { return }
    //
    //            var favorites = [Product]()
    //            for item in rawData {
    //                guard let itemArray = item as? [String: AnyObject]
    //                    else {continue}
    //
    //                let pro = Product()
    //                if itemArray.count > 0 {
    //                    pro.productId = itemArray["id"] as? Int
    //
    //                }
    //                if itemArray.count > 1 {
    //                    pro.productName = itemArray["name"] as? String
    //                }
    //
    //                if itemArray.count > 2 {
    //                    pro.productHealth = itemArray["health"] as? String
    //                }
    //
    //                if itemArray.count > 3 {
    //                    pro.productPrice = itemArray["price"] as? Int
    //                }
    //
    //                if itemArray.count > 4 {
    //                    pro.productImage = itemArray["url"] as? String
    //                }
    //
    //                favorites.append(pro)
    //            }
    //            self.dataLength = favorites.count
    //            self.sourceFavorites = favorites
    //        }
    //    }
    
    func removeAlert(id: Int?) { //pass the id into function
        let controller = UIAlertController(title: "Oops", message: "Would you like to remove the item?", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            
            //Delete from firebase
            
            
        }))
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(controller, animated: true)
        
        
    }
    
}

