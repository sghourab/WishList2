//
//  ProductDetailsCollectionView.swift
//  WishList2
//
//  Created by Summer Crow on 03/01/2019.
//  Copyright © 2019 ghourab. All rights reserved.
//

import UIKit
import CoreData

//class ImagesinProductDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
//    
//    @IBOutlet weak var collectionView: UICollectionView!
//    
//    var imageArray = [ProductImage]()
//    
//    var selectedProduct: ProductDetails? {
//        didSet {
//            loadImages()
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let dataImageFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        print(dataImageFilePath)
//    }
//    //MARK:- TABLEVIEW DATASOURCE METHODS
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imageArray.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productImageCell", for: indexPath) as! ProductDetailsCollectionViewCell
//        
//        cell.imageData = imageArray[indexPath.item]
//        
//        return cell
//    }
//    //MARK:- loading Images from Core Data Entity 'Image'
//    
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
//}
