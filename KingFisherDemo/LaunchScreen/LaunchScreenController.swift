//
//  LaunchScreenController.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 1/26/20.
//  Copyright © 2020 Chris Hagedorn. All rights reserved.
//

import UIKit

class LaunchScreenController: UIViewController {
    
    @IBOutlet fileprivate weak var loadingLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { //Wait 1 sec.
        
        UIView.animate(withDuration: 4.0, animations: {
            self.loadingLabel.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
            self.view.backgroundColor = UIColor.white
            
        }) {(success) in
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateInitialViewController()
            UIApplication.shared.keyWindow?.rootViewController = vc
        }

    }

}
}
