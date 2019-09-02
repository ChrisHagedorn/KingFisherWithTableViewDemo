//
//  OrderInfoController.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/28/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit

class OrderInfoController: UIViewController {
    @IBOutlet weak var footerView: ShoppingCartFooter!
    
    @IBAction func confirmOrder(_ sender: Any) {
        let vc = CheckoutController.create()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static func create() ->  OrderInfoController {
            return UIStoryboard(name: "OrderInfoController", bundle: nil).instantiateViewController(withIdentifier: "OrderInfoController") as! OrderInfoController
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        footerView.buttonHide()
        //TODO: Hide Tab bar
        self.tabBarController!.tabBar.isHidden = true
    }
    
}
