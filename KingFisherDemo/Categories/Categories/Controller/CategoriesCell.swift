//
//  CategoriesCell.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/20/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit

class CategoriesCell: UITableViewCell {
    
    @IBOutlet weak var productHealth: UILabel!
    var data: Category?
    
    func setData(data: Category) {
        self.data = data
        productHealth.text = data.name
    }
    
}


