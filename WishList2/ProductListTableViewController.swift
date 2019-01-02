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

    //var productNameArray = [ProductDetails]()
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(dataFilePath)
        loadProductNameList()
        print(productArray)
        tableView.reloadData()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductList", for: indexPath)
        
        let productName = productArray[indexPath.row]
        cell.textLabel?.text = productName.productTitle
        if let imageListed = productName.productImage
        {
    
        cell.imageView?.image = UIImage(data: imageListed)
        }
        else {
           cell.imageView?.image = UIImage(named: "product")
            
        }

        // Configure the cell...

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
            
        let product = productArray[indexPath.row]
        productArray.remove(at: indexPath.row)
        context.delete(product)
            
        tableView.reloadData()
        }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails"{
        let destinationVC = segue.destination as! ProductDetailsVC
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.productArrayIndex = indexPath.row
        }
    }
        
    }
    //MARK: - SAVE AND LOAD TO CORE DATA FUNCTIONS
    
    
    func loadProductNameList(){
        //let request:NSFetchRequest<ProductDetails> = ProductDetails.fetchRequest()
        
        do {
            productArray = try context.fetch(request)
        } catch {
            print("error loading category context: \(error)")
        }
        tableView.reloadData()
    }
   

}
