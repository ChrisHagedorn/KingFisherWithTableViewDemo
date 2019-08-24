//
//  CategoriesController.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/20/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Category {
    var id: String
    var name: String
    init(name: String) {
        id = UUID().uuidString
        self.name = name
    }
}

class CategoriesController: UIViewController {
    
    static func create() -> CategoriesController {
        return UIStoryboard(name: "Categories", bundle: nil).instantiateInitialViewController() as! CategoriesController
    }
    
    @IBOutlet weak var tableView: UITableView!

    var datasource = [Category]() { didSet {
        tableView.reloadData()
        }}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getData()
        
    }
    
    func getData() {
        datasource = [
            Category(name: "Beverage"),
            Category(name: "Bottle Products"),
            Category(name: "Bread and Bakery"),
            Category(name: "Canned Products"),
            Category(name: "Dairy"),
            Category(name: "Deli and Cheese"),
        ]
        
    }
    
    
}

extension CategoriesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell" ) as! CategoriesCell
        cell.setData(data: datasource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = CategoriesDetailController.create()
        controller.data = datasource[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    
}
