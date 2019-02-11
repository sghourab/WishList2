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

struct productCoreData{

    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

static var image:UIImage?

static let request: NSFetchRequest<ProductDetails> = ProductDetails.fetchRequest()

static let imageRequest: NSFetchRequest<ProductImage> = ProductImage.fetchRequest()

static var productArrayforCD = [ProductDetails]()

static var imageArrayforCD = [ProductImage]()

}

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
        
        if productTitleLabel.text == "" {

            let alert = UIAlertController(title: "Please enter a product name", message: "", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))

            self.present(alert, animated: true)
        }
        
        
        else {
            
        let newProduct = ProductDetails(context: productCoreData.context)
        newProduct.productTitle = productTitleLabel.text
        newProduct.productDescription = productDescriptionTextView.text
        productCoreData.productArrayforCD.append(newProduct)
      
        saveProduct()
       

        
        for image in imageArrayaddNewProductVC {
        let newImage = ProductImage(context: productCoreData.context)
        let imageData = image.jpegData(compressionQuality: 1)

            //newImage.parentProductDetails = newProduct
            newImage.image = imageData
            newProduct.addToImage(newImage)

            print("imageData : \(imageData)")
           // imageArrayforCD.append(newImage)
            print("imageData: \(newImage)")
            print("imageArrayaddNewProductVC: \(imageArrayaddNewProductVC.count)")
            print("imageArrayforCD count : \(productCoreData.imageArrayforCD.count)")

             saveProduct()
            
            }
        
        
        
        
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)

        }
        
    }

    //MARK:- CORE DATA MANIPULATION METHODS
    
    func saveProduct() {
        do {
            try productCoreData.context.save()
        }
        catch {
            print("error saving context: \(error)")
        }
    }
    
    func loadProduct(){
        
        
        do {
            productCoreData.productArrayforCD = try productCoreData.context.fetch(productCoreData.request)
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
    
    

}
