//
//  ProductHeaderView.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/12/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit

protocol ProductHeaderDelegate {
    func didTapShoppingCart()
}

class ProductHeaderView: UIView {
    
    
    @IBAction func shoppingCart(_ sender: UIButton) { //Shopping Cart Segue
        delegate?.didTapShoppingCart()
    }
    
    var delegate: ProductHeaderDelegate?
    var datasource = [Product]() { didSet {
        collectionView.reloadData()
        }}
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FeaturedFoodCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedFoodCell")
    }
}


extension ProductHeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedFoodCell", for: indexPath) as! FeaturedFoodCell
        cell.setData(datasource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let screenWidth = UIScreen.main.bounds.width
        //let width = (screenWidth - 16) * 2 / 3
        //return CGSize(width: width, height: collectionView.frame.height)
        return CGSize(width: collectionView.frame.width * 0.67, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = ProductDetailViewController.create()
        controller.data = datasource[indexPath.row]
        //TODO: Move to new controller by pushing it onto stack
        }
    
}
