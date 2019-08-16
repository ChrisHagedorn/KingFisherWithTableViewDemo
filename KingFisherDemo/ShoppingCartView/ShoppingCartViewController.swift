//
//  ShoppingCartViewController.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/16/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillAppear(false)
        

        // Do any additional setup after loading the view.
    }
    
    //Hides top and bottom of view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated) //Hides top navigation
        self.tabBarController?.tabBar.isHidden = true //Hides bottom navigation
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


