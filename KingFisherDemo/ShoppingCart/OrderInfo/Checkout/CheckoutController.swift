//
//  CheckoutController.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/28/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit

class CheckoutController: UIViewController {
    
    static func create() ->  CheckoutController {
        return UIStoryboard(name: "CheckoutController", bundle: nil).instantiateViewController(withIdentifier: "CheckoutController") as! CheckoutController
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
