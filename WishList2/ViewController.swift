//
//  ViewController.swift
//  WishList2
//
//  Created by Summer Crow on 19/12/2018.
//  Copyright © 2018 ghourab. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var productArray = [ProductDetails]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var productNameTextField: UITextField!
    
    @IBOutlet weak var productUIImage: UIImageView!
    @IBOutlet weak var productDescriptionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(dataFilePath)
        loadProduct()
        
        
        
    }
    //MARK:- TAKE PHOTO FUNCTION
    @IBAction func takePhotoAction(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage =
            info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            productUIImage.contentMode = .scaleAspectFit
            productUIImage.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- UPLOAD PHOTO FUNCTION
    @IBAction func uplaodPhotoAction(_ sender: Any) {
        
    }
    
    //MARK:- SAVE ALL PRODUCT DETAILS ACTION BUTTON
    @IBAction func saveProductAction(_ sender: Any) {
        let newProduct = ProductDetails(context: self.context)
        newProduct.productTitle = productNameTextField.text
        newProduct.productDescription = productDescriptionTextView.text
        
        productArray.append(newProduct)
        saveProduct()
    }
    
    //MARK:- SAVE PRODUCT DETAILS TO CORE DATA
    
    func saveProduct(){
        do {
            try context.save()
        }
        catch {
            print("error saving context: \(error)")
        }
    }
    //MARK:- LOAD PRODUCT DETAILS FROM CORE DATA
    
    func loadProduct(){
        let request: NSFetchRequest<ProductDetails> =
        ProductDetails.fetchRequest()
        do {
            productArray = try context.fetch(request)
        } catch {
            print("error loading items: \(error)")
        }
    }
    
}

