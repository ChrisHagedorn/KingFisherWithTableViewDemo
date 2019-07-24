//
//  TableViewController.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 7/23/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit

var product: [Product] = []
var row = 0

class TableViewController: UITableViewController {
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        product = createArray()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func createArray() -> [Product] { //Method will read from Google Database later
        
        let product1 = Product(productName: "The Green Apple", productHealth: "Healthy", productPrice: 20, productImage: "https://fortmyersoliveoil.com/wp-content/uploads/2018/05/apple.jpg")
        let product2 = Product(productName: "The Original Orange", productHealth: "Healthy", productPrice: 30, productImage: "https://i.imgur.com/VPjrc6r.jpg")
         let product3 = Product(productName: "The Big Banana", productHealth: "Very Big", productPrice: 40, productImage: "https://i.imgur.com/8lE9Gmc.jpg")
        let product4 = Product(productName: "The Beefy Burger", productHealth: "Very Healthy", productPrice: 50, productImage: "https://ak9.picdn.net/shutterstock/videos/4198369/thumb/8.jpg")
        let product5 = Product(productName: "Peanut Butter", productHealth: "Crunchy", productPrice: 60, productImage: "https://pinchofyum.com/wp-content/uploads/Homemade-Peanut-Butter-Recipe.jpg")
        let product6 = Product(productName: "Bubbles", productHealth: "Uhh", productPrice: 70, productImage: "https://ichef.bbci.co.uk/news/660/cpsprodpb/B141/production/_106077354_gettyimages-936748654.jpg")
        
        
        return[product1, product2, product3, product4, product5, product6]
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let products = product[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell" ) as! TableViewCell
        cell.layer.borderWidth = 10
        cell.layer.borderColor = #colorLiteral(red: 0.9600740075, green: 0.9602344632, blue: 0.9600527883, alpha: 1)
            
        cell.setProduct(product: products)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row = indexPath.row
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
