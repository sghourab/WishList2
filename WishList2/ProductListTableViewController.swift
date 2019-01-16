//
//  ProductListTableViewController.swift
//  WishList2
//
//  Created by Summer Crow on 19/12/2018.
//  Copyright © 2018 ghourab. All rights reserved.
//

import UIKit
import CoreData


class ProductListTableViewController: UITableViewController {

 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(dataFilePath)
       
        loadProductNameList()
        loadProductImagesList()
        
        
        print(productArrayforCD)
        
        tableView.reloadData()
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        
    }
    
    //MARK: - Add New Product Action
    @IBAction func addNewProductAction(_ sender: Any) {
        performSegue(withIdentifier: "goToNewItem", sender: self)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productArrayforCD.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductList", for: indexPath)
        
        let productName = productArrayforCD[indexPath.row]
        
        cell.textLabel?.text = productName.productTitle

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetails", sender: self)
    }
    
    
    
    //MARK:- DELETING DATA FROM PRODUCT LIST AND CORE DATA
  
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
        let product = productArrayforCD[indexPath.row]
        productArrayforCD.remove(at: indexPath.row)
        context.delete(product)
            
        tableView.reloadData()
        }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
      
        if segue.identifier == "goToDetails"{
        
        let destinationVC = segue.destination as! ProductDetailsVC
        
            guard let selectedRow = self.tableView.indexPathForSelectedRow?.row else {
                return
            }
        destinationVC.selectedProduct = productArrayforCD[selectedRow]
            
           
        }
        
//
            //destinationVC.index
    }
        
    
    
    //MARK: - SAVE AND LOAD TO CORE DATA FUNCTIONS
    
    
    func loadProductNameList(){
        
        let request:NSFetchRequest<ProductDetails> = ProductDetails.fetchRequest()
        
  
        do {
            productArrayforCD = try context.fetch(request)
            //imageArrayforCD = try context.fetch(imageRequest)
        } catch {
            print("error loading category context: \(error)")
        }
        tableView.reloadData()
    }
   
    func loadProductImagesList() {
        
        let imageRequest: NSFetchRequest<ProductImage> = ProductImage.fetchRequest()
        
       // let productPredicate = NSPredicate(format: "parentProductDetails.productTitle MATCHES %@", productNameGlobal)
        
        //imageRequest.predicate = productPredicate
        
        do {
            imageArrayforCD = try context.fetch(imageRequest)
        } catch {
            print("error loading images context: \(error)")
        }
        tableView.reloadData()
        
        
        
    }
    
}


