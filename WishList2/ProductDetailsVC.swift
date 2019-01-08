//
//  ProductDetailsVC.swift
//  WishList2
//
//  Created by Summer Crow on 24/12/2018.
//  Copyright © 2018 ghourab. All rights reserved.
//

import UIKit
import CoreData

class ProductDetailsVC: UIViewController {
    
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var productArrayIndex = Int()
    
    var imageArray = [ProductImage]()
    
//    var selectedProduct: ProductDetails? {
//        didSet {
//            loadImages()
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadProductNameList()
        let product = productArray[productArrayIndex]
        productLabel.text = product.productTitle
        if let image = product.productImage {
            productImage.image = UIImage(data: image)
            
        } else {
            productImage?.image = UIImage(named: "product")
        }
        productDescription.text = product.productDescription
    }
    
    func loadProductNameList(){
        //let request:NSFetchRequest<ProductDetails> = ProductDetails.fetchRequest()
        
        do {
            productArray = try context.fetch(request)
        } catch {
            print("error loading category context: \(error)")
        }
        
    }
    
}

extension ProductDetailsVC: UICollectionViewDataSource {
    
    
    
    
    
    //MARK:- TABLEVIEW DATASOURCE METHODS
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productImageCell", for: indexPath) as! ProductDetailsCollectionViewCell
        
        //cell.image = imageArray[indexPath.item]
        
        return cell
    }
    //MARK:- loading Images from Core Data Entity 'Image'
    
//    func loadImages(){
//        
//        let request: NSFetchRequest<ProductImage> = ProductImage.fetchRequest()
//        
//        do{
//            imageArray = try context.fetch(request)
//        } catch{
//            print("error loading images: \(error)")
//        }
//        collectionView.reloadData()
//    }
}
