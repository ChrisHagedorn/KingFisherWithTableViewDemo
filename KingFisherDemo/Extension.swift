//
//  Extension.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/12/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloadImage(from url: String?, placeholder: UIImage? = nil) {
        guard let url = url, let nsurl = URL(string: url) else { return }
        kf.setImage(with: ImageResource(downloadURL: nsurl), placeholder: placeholder)
    }
}

extension UIView {
    func xibSetup() {
        backgroundColor = UIColor.clear
        let view = loadNib()
        view.frame = bounds
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
    }
    
    
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}

extension Array where Element: Equatable {
    mutating func removeDuplicates() {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        self = result
    }
}



extension UIApplication {
    class func topVC(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topVC(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topVC(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topVC(presented)
        }
        return base
    }
    
    class func present(_ controller: UIViewController) {
        let topController = topVC()
        topController?.present(controller, animated: true)
    }
    
    class func push(_ controller: UIViewController) {
        let topController = topVC()
        topController?.navigationController?.pushViewController(controller, animated: true)
    }
}
