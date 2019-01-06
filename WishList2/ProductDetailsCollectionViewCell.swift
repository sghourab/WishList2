//
//  ProductDetailsCollectionViewCell.swift
//  WishList2
//
//  Created by Summer Crow on 03/01/2019.
//  Copyright © 2019 ghourab. All rights reserved.
//

import UIKit

class ProductDetailsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productUIImage: UIImageView!
    
    var imageData: ProductImage? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
      
        
        if let imageData = imageData?.image {
            let image = UIImage(data: imageData)
            productUIImage.image = image
        } else {
            productUIImage.image = nil
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 5, height: 10)
        
        self.clipsToBounds = false
    }
}
