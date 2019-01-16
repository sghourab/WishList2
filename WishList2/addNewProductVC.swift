//
//  addNewProductVC.swift
//  WishList2
//
//  Created by Summer Crow on 24/12/2018.
//  Copyright © 2018 ghourab. All rights reserved.
//

import UIKit
import CoreData


////Images not sent back properly to imageArrayAddNewProductVC
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

var image:UIImage?

let request: NSFetchRequest<ProductDetails> = ProductDetails.fetchRequest()

let imageRequest: NSFetchRequest<ProductImage> = ProductImage.fetchRequest()

var productArrayforCD = [ProductDetails]()

var imageArrayforCD = [ProductImage]()



class addNewProductVC: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImagesAddedDelegate {
    
    
    @IBOutlet weak var productTitleLabel: UITextField!
    
    @IBOutlet weak var productUIImage: UIImageView!
   
    @IBOutlet weak var productDescriptionTextView: UITextView!
    
   
    
    
    //let imagePicker = UIImagePickerController()
    
    var imageArrayaddNewProductVC = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(dataFilePath)
        //setting up placeholder for product description text view
        
        productDescriptionTextView.delegate = self
        productDescriptionTextView.text = "Enter product description here"
        productDescriptionTextView.textColor = UIColor.lightGray
       
        hideKeyboardWhenTappedAround()
        
    }

    
    
    
   
    //MARK:- Perform Segue Methods
    
    @IBAction func addPhotosVCSegueAction(_ sender: Any) {
        performSegue(withIdentifier: "goToAddPhotosVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToAddPhotosVC" {
            
            let destinationVC = segue.destination as! AddPhotoVC
            
            destinationVC.delegate = self
            
            destinationVC.imageArrayAddPhotoVC = imageArrayaddNewProductVC
            
          //  destinationVC.imageArrayAddPhotoVC = imageArrayaddNewProductVC
            

        }
    }
    
    //MARK:- this func will be fired when going back from AddPhotoVC to current VC.
    
    func photoSelectionCompleted(images: [UIImage]) {
       
     if images == [] {
    productUIImage.image = UIImage(named: "imagePlaceholder")
} else {
    productUIImage.image = images[0]
    imageArrayaddNewProductVC = images
   
        
        
      }
            
        
    }
   
    //MARK:- Update Core Data with new Product save button Action
    @IBAction func saveDetailsAction(_ sender: Any) {
        
        let newProduct = ProductDetails(context: context)
        newProduct.productTitle = productTitleLabel.text
        newProduct.productDescription = productDescriptionTextView.text
        productArrayforCD.append(newProduct)
      
        saveProduct()
       
//        let newImage = ProductImage(context: context)
//        let image1 = imageArrayaddNewProductVC[0]
//        let image1Data = image1.jpegData(compressionQuality: 1)
//        newImage.image = image1Data
//        newProduct.addToImage(newImage)
//        saveProduct()
//
//        let newImage2 = ProductImage(context: context)
//        let image2 = imageArrayaddNewProductVC[1]
//        let image2Data = image2.jpegData(compressionQuality: 1)
//        newImage.image = image2Data
//        newProduct.addToImage(newImage2)
//        saveProduct()
        
        for image in imageArrayaddNewProductVC {
        let newImage = ProductImage(context: context)
        let imageData = image.jpegData(compressionQuality: 1)

            //newImage.parentProductDetails = newProduct
            newImage.image = imageData
            newProduct.addToImage(newImage)

            print("imageData : \(imageData)")
           // imageArrayforCD.append(newImage)
            print("imageData: \(newImage)")
            print("imageArrayaddNewProductVC: \(imageArrayaddNewProductVC.count)")
            print("imageArrayforCD count : \(imageArrayforCD.count)")

             saveProduct()
        }
        
        
//        let imageData = image?.jpegData(compressionQuality: 1)
//        newProduct.productImage = imageData
        
        
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)

        
        
    }

    //MARK:- CORE DATA MANIPULATION METHODS
    
    func saveProduct() {
        do {
            try context.save()
        }
        catch {
            print("error saving context: \(error)")
        }
    }
    
    func loadProduct(){
        
        
        do {
            productArrayforCD = try context.fetch(request)
        } catch {
            print("error loading items: \(error)")
        }
    }
    
   
    
    //MARK:- Adding a placeholder to textview
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.textColor = UIColor.lightGray
            textView.text = "Enter product description here"
        }
    }
}



//MARK:- hiding keyboard when editing done

extension UIViewController {
    func hideKeyboardWhenTappedAround(){
        let tapGeture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGeture)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    
//    func routeToParent(segue: UIStoryboardSegue?) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let destinationVC = storyboard.instantiateViewController(withIdentifier: "backToProducts") as! ProductListTableViewController
//        var destinationDS = destinationVC.productNameArray
//    }
}
