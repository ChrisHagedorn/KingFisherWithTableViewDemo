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
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
    }
    
    var data: Product?
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    var dataLength: Int?
    var sourceFavorites: [Product] = []

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productCatagory: UILabel!
    @IBOutlet weak var productHealth: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    @IBAction func addToFavorites(_ sender: Any) {
        
        ref = Database.database().reference()
        guard let userKey = Auth.auth().currentUser?.uid else {return}
        
        for index in 0...dataLength! - 1{
            if sourceFavorites[index].productId! == data?.productId {
                print ("Item is in array")
                break
                
            }else{
               print("Added \(data!.productName ?? "fred") to Favorites")
                ref.child("favorites").child(userKey).child(String(dataLength! + 1)).setValue([
                    "id": data!.productId,
                    "name": data!.productName,
                    "health": data!.productHealth,
                    "price": data!.productPrice,
                    "url": data!.productImage, ])
            }
        }

    }
    
    @IBAction func addToCart(_ sender: Any) {
        itemsInCart.append(data!)
        print("Added \(data!.productName ?? "Uknown") to Cart")
        
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
        getFavorites()
    }
    
//    func checkIfItemIsInFavorites() -> Bool{
//        guard let userKey = Auth.auth().currentUser?.uid else { return true }
//
//
//    }
//
    func getFavorites(){
        ref = Database.database().reference()
        guard let userKey = Auth.auth().currentUser?.uid else {return}
        databaseHandle = ref.child("favorites").child(userKey).observe(.value){
            (snapshot) in
            
            guard let rawData = snapshot.value as? [AnyObject] else { return }
            
            var favorites = [Product]()
            for item in rawData {
                guard let itemArray = item as? [String: AnyObject]
                    else {continue}
                
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
                
                favorites.append(pro)
            }
            self.dataLength = favorites.count
            self.sourceFavorites = favorites
        }
    }

}
