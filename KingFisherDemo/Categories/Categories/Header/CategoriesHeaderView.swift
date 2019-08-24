//
//  CategoriesHeaderView.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/20/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit

class CategoriesHeaderView: UIView {
    @IBOutlet weak var favoritesBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var exploreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
        
    }

}
