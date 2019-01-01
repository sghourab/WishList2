//
//  addNewProductVC.swift
//  WishList2
//
//  Created by Summer Crow on 24/12/2018.
//  Copyright © 2018 ghourab. All rights reserved.
//

import UIKit
import CoreData

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
var image:UIImage?
let request: NSFetchRequest<ProductDetails> = ProductDetails.fetchRequest()
var productArray = [ProductDetails]()

class addNewProductVC: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var productTitleLabel: UITextField!
    @IBOutlet weak var productUIImage: UIImageView!
    @IBOutlet weak var productDescriptionTextView: UITextView!
    
    
    
    
    
    
    
    
    
    let imagePicker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(dataFilePath)
   
       hideKeyboardWhenTappedAround()
        
    }

    
    //MARK: - Take a Photo Action
    
    @IBAction func takeAPhotoAction(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            productUIImage.image = pickedImage
            image = pickedImage
            productUIImage.contentMode = .scaleAspectFill
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Upload an Image from Media
    
   
    
    //:- Update Core Data with new Product save button Action
    @IBAction func saveDetailsAction(_ sender: Any) {
        
        let newProduct = ProductDetails(context: context)
        newProduct.productTitle = productTitleLabel.text
        newProduct.productDescription = productDescriptionTextView.text
        
        //guard let imageData = UIImageJPEGRepresentation
        let imageData = image?.jpegData(compressionQuality: 1)
        newProduct.productImage = imageData
        productArray.append(newProduct)
        saveProduct()
        
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
            productArray = try context.fetch(request)
        } catch {
            print("error loading items: \(error)")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

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
