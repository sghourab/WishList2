//
//  photoFullScreenVC.swift
//  WishList2
//
//  Created by Summer Crow on 06/01/2019.
//  Copyright © 2019 ghourab. All rights reserved.
//

import UIKit
import CoreData


//MUST SEND DATA BACKWARDS IF PHOTO DELETED!!!!////////


var imageArray = [ProductImage]()

protocol DataEnteredDelegate: class {
    func userDidAddImages(images: [UIImage])
}

/////////////////////////////////////////

class photoFullScreenVC: UIViewController {
    
    @IBOutlet weak var fullScreenPhoto: UIImageView!
    
    var imageArrayIndex = Int()
    
    var imagesArray = [UIImage]()
    
    weak var delegate: DataEnteredDelegate? = nil
    
    
    override func viewDidLoad() {
        //print(imageArrayIndex)
        super.viewDidLoad()
        //loadImages()
        let fullSizePhoto = imagesArray[imageArrayIndex]
        fullScreenPhoto.image = fullSizePhoto
            }
    
    
    //MARK:- pressing the delete button fires func below. Image will be removed from imagesArray.
    
    @IBAction func deletePhotoAction(_ sender: Any) {
        
        let image = imagesArray[imageArrayIndex]
        imagesArray.remove(at: imageArrayIndex)
        //context.delete(image)
        fullScreenPhoto.image = UIImage(named: "imagePlaceholder")
    }
    
    
  
    //MARK:- func below will be fired after pressing back button. It allows sending the array of Images back to the AddPhotoVC. i.e. from imagesArray in current VC to tempImageArray in AddPhotoVC.
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {

            delegate?.userDidAddImages(images: imagesArray)

    
        }
    }
 
    func loadImages(){
        
        let request: NSFetchRequest<ProductImage> = ProductImage.fetchRequest()
        
        do{
            imageArray = try productCoreData.context.fetch(request)
        } catch{
            print("error loading images: \(error)")
        }
    }
    
    
}
