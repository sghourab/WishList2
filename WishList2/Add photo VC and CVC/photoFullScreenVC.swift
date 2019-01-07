//
//  photoFullScreenVC.swift
//  WishList2
//
//  Created by Summer Crow on 06/01/2019.
//  Copyright © 2019 ghourab. All rights reserved.
//

import UIKit
import CoreData

var imageArray = [ProductImage]()

class photoFullScreenVC: UIViewController {
    @IBOutlet weak var fullScreenPhoto: UIImageView!
    
    var imageArrayIndex = Int()
    
    
    override func viewDidLoad() {
        //print(imageArrayIndex)
        super.viewDidLoad()
        loadImages()
        let fullSizePhoto = UIImage(data: imageArray[imageArrayIndex].image!)
        fullScreenPhoto.image = fullSizePhoto
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func deletePhotoAction(_ sender: Any) {
        
        let image = imageArray[imageArrayIndex]
        imageArray.remove(at: imageArrayIndex)
        context.delete(image)
        fullScreenPhoto.image = UIImage(named: "imagePlaceholder")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
 
    func loadImages(){
        
        let request: NSFetchRequest<ProductImage> = ProductImage.fetchRequest()
        
        do{
            imageArray = try context.fetch(request)
        } catch{
            print("error loading images: \(error)")
        }
    }
}
