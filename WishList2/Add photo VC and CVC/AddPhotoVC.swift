//
//  AddPhotoVC.swift
//  WishList2
//
//  Created by Summer Crow on 03/01/2019.
//  Copyright © 2019 ghourab. All rights reserved.
//

import UIKit

class AddPhotoVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tempImageView: UIImageView!
    var imageArray = [ProductImage]()
    //var images = [UIImage]()

    @IBOutlet weak var addImagesCollectionView: UICollectionView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addImagesCollectionView.delegate = self
        addImagesCollectionView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        addImagesCollectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addPhoto", for: indexPath) as! AddPhotoCollectionViewCell
        
       
        
        let collectionViewImage = imageArray[indexPath.row].image
        
        cell.addPhotoImage?.image = UIImage(data: collectionViewImage!)
        
    
        
        
        return cell
    }
    
    

   
    
    @IBAction func takePhotoAction(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let newImage = ProductImage(context: context)
            newImage.image = pickedImage.jpegData(compressionQuality: 1)
            imageArray.append(newImage)
            tempImageView.image = pickedImage
            
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
    
    func loadImage(){
        
        
        do {
            productArray = try context.fetch(request)
        } catch {
            print("error loading items: \(error)")
        }
        addImagesCollectionView.reloadData()
    }
}
