//
//  ProductDetailFooterView.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 1/20/20.
//  Copyright © 2020 Chris Hagedorn. All rights reserved.
//

import UIKit

class ProductDetailFooterView: UIView {
    var datasource = [Product]() { didSet {
        collectionView.reloadData()
        }}
    
    @IBOutlet weak var collectionView: UICollectionView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ProductDetailFooter", bundle: nil), forCellWithReuseIdentifier: "ProductDetailFooterCell")
        
    }

}

extension ProductDetailFooterView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailFooterCell", for: indexPath) as! ProductDetailFooterCell
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
        (superview?.next as? UIViewController)?.navigationController?.pushViewController(controller, animated: true)
        //TODO: Double check with Ky
        }
    
}

