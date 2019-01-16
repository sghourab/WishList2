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
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var imageArray = [ProductImage]()
    
   var selectedProduct: ProductDetails?
   //{
//        didSet {
//            loadImages()
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //loadProductNameList()
        
        productLabel.text = selectedProduct?.productTitle
        productDescription.text = selectedProduct?.productDescription
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
//    func loadProductNameList(){
//        //let request:NSFetchRequest<ProductDetails> = ProductDetails.fetchRequest()
//
//        do {
//            productArrayforCD = try context.fetch(request)
//        } catch {
//            print("error loading category context: \(error)")
//        }
//
//    }
    
}

extension ProductDetailsVC: UICollectionViewDataSource,  UICollectionViewDelegate {
    
    
    //MARK:- TABLEVIEW DATASOURCE METHODS
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of images \(selectedProduct?.image?.allObjects.count)")
        return selectedProduct?.image?.count ?? 0
  
    
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productImageCell", for: indexPath) as! ProductDetailsCollectionViewCell
        
        let setOfProductImages = selectedProduct?.image?.allObjects as! [ProductImage]
        print(setOfProductImages.count)
        print(setOfProductImages[0])
        if let singleImageInDataFormat = setOfProductImages[indexPath.item].image, let singleImageInUIImageFormat = UIImage(data: singleImageInDataFormat) {
            cell.productUIImage.image = singleImageInUIImageFormat
            
        }
        else {
            cell.productUIImage.image = UIImage(named: "product")
        }
        
        
        
        
//        let imagesInUIImageFormat = setOfImages.map {UIImage(data: ($0))}
//        print(imagesInUIImageFormat.count)
//        cell.productUIImage.image = imagesInUIImageFormat[indexPath.item]
        
        
//        if let expense = category?.expenses?[indexPath.row]{
//            cell.textLabel?.text = expense.name
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
