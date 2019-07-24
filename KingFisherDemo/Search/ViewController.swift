//
//  ViewController.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 7/22/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {

        super.viewDidLoad()
        let url = URL(string: "https://i.imgur.com/5ylZG2o.jpg")
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

