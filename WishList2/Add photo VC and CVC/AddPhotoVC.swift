//
//  AddPhotoVC.swift
//  WishList2
//
//  Created by Summer Crow on 03/01/2019.
//  Copyright © 2019 ghourab. All rights reserved.
//

import UIKit
import CoreData



protocol ImagesAddedDelegate: class {
    func photoSelectionCompleted(images: [UIImage])
}



class AddPhotoVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, DataEnteredDelegate {
    


    var imageArrayAddPhotoVC: [UIImage] = []
    
    var imageIndex = Int()
    
    weak var delegate: ImagesAddedDelegate? = nil

    @IBOutlet weak var addImagesCollectionView: UICollectionView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //loadImages()
        
        addImagesCollectionView.reloadData()
        
        addImagesCollectionView.delegate = self
       
        addImagesCollectionView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        addImagesCollectionView.reloadData()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 9
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addPhoto", for: indexPath) as! AddPhotoCollectionViewCell
       
      // If the number of photos is greater than the index of the current cell being populated
        if (imageArrayAddPhotoVC.count > indexPath.item)
       {
        cell.cellImage?.image =  imageArrayAddPhotoVC[indexPath.item]
        cell.cellType = "productPhoto"
    
        }
        else if indexPath.item == imageArrayAddPhotoVC.count {
        
        cell.cellImage?.image = UIImage(named: "cameraAdd")
        cell.cellType = "addAction"
       }
       else{
        cell.cellImage?.image = UIImage(named: "imagePlaceholder")
        cell.cellType = "dummyImage"
        }

        return cell
//
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AddPhotoCollectionViewCell
        
        
        if cell.cellType == "addAction"{
        takePhotoAction(cell)
        }
        else if cell.cellType == "productPhoto" {
        imageIndex = indexPath.item
            performSegue(withIdentifier: "goToPhotoEdit", sender: self)
            
        
            print("imageIndex:  \(imageIndex)")
        
   }
    }
    // MARK:- Preparing to segue forward into photoFullScreenVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPhotoEdit"{
            let destinationVC = segue.destination as! photoFullScreenVC
            
        destinationVC.imageArrayIndex = imageIndex
            destinationVC.imagesArray = imageArrayAddPhotoVC
        destinationVC.delegate = self
            
        
        }
        
    }
    
    //MARK:- this function is called when going back to addNewProductVC. Allows the passing of the image Array.
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
           
            delegate?.photoSelectionCompleted(images: imageArrayAddPhotoVC)
            
            
        }
        
    }
    
    //MARK:- function to allow passing of images backward from photoFullScreenVC to AddPhotoVC
    
    func userDidAddImages(images: [UIImage]) {
        imageArrayAddPhotoVC = images
    }
    
    //MARK:- Actions to take photo.
    
    func takePhotoAction(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            /////Need to pass back all the details commented out below
            
//            let newImage = ProductImage(context: context)
//            newImage.image = pickedImage.jpegData(compressionQuality: 1)
//            newImage.parentProductDetails = selectedProduct
//            imageArray.append(newImage)
            
            imageArrayAddPhotoVC.append(pickedImage)
            
            
            addImagesCollectionView.reloadData()
            saveImage()
            
        }
        picker.dismiss(animated: true, completion: nil)
        addImagesCollectionView.reloadData()
    }
    

    
    //MARK:- CORE DATA MANIPULATION METHODS
    
    func saveImage() {
        do {
            try context.save()
        }
        catch {
            print("error saving context: \(error)")
        }
    }
    
    func loadImages(){
        
        let request: NSFetchRequest<ProductImage> = ProductImage.fetchRequest()
        
        do{
            imageArray = try context.fetch(request)
        } catch{
            print("error loading images: \(error)")
        }
    }
    
//    func deleteAllData(entity: String) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
//        fetchRequest.returnsObjectsAsFaults = false
//
//        do
//        {
//            let results = try managedContext.fetch(fetchRequest)
//            for managedObject in results
//            {
//                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
//                managedContext.delete(managedObjectData)
//            }
//        } catch let error as NSError {
//            print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
//        }
//    }
}
