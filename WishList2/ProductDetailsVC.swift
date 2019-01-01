//
//  ProductDetailsVC.swift
//  WishList2
//
//  Created by Summer Crow on 24/12/2018.
//  Copyright © 2018 ghourab. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {
    
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UITextView!
    
    var productArrayIndex = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadProductNameList()
        let product = productArray[productArrayIndex]
        productLabel.text = product.productTitle
        if let image = product.productImage {
            productImage.image = UIImage(data: image)
            
        } else {
            productImage?.image = UIImage(named: "photo4")
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
