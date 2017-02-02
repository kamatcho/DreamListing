//
//  AddAndEditItem.swift
//  DreamListing
//
//  Created by MOHAMED on 1/28/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import CoreData

class AddAndEditItem: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource, UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var ProductName: UITextField!
    @IBOutlet weak var ProductPrice: UITextField!
    @IBOutlet weak var PickerStoreView: UIPickerView!
    @IBOutlet weak var ProductDetails: UITextField!
    @IBOutlet weak var ImageTool: UIImageView!
    var ImagePicker : UIImagePickerController!
    var StoreData = [Store]()
    var EditOrDelete :Item?
    override func viewDidLoad() {
        super.viewDidLoad()
        if EditOrDelete != nil {
            LoadItem()
        }
        LoadStores()
        ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        PickerStoreView.delegate = self
        PickerStoreView.dataSource = self
        
     
        
        // Do any additional setup after loading the view.
    }
 
    // Picker View Functions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return StoreData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let StoreTitle = StoreData[row]
       // print(StoreTitle.name)
        return StoreTitle.name
    }
    
    // End Of Picker View Functions
    
    // Back Button
    
    
    // Load Stores Functions
    
    func LoadStores() {
        let store : NSFetchRequest<Store> = Store.fetchRequest()
        do {
            StoreData = try context.fetch(store)
            
        }catch{
            print("Error")
        }
        
    }
    // Pick Image From Photo Or Camera Roll
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            ImageTool.image = image
        }
        ImagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    
    // Add Image Button
    
    @IBAction func AddImageBtn(_ sender: Any) {
        present(ImagePicker, animated: true, completion: nil)
    }
    
    // Add Or Edit Item Functions
    @IBAction func SaveData(_ sender: Any) {
        
        let itemData : Item!
        if EditOrDelete == nil {
             itemData = Item(context: context)
           
        }else {
            itemData = EditOrDelete
        }
        itemData.created = NSDate()
        itemData.title = ProductName.text
        itemData.price = Double(ProductPrice.text!)!
        let picture = Image(context: context)
        picture.image = ImageTool.image
        itemData.toImage = picture
        itemData.toStore = StoreData[PickerStoreView.selectedRow(inComponent: 0)]
        
        itemData.details = ProductDetails.text
        do{
            ad.saveContext()
            
        }
    }
    // End Of Saving Data
    
    // Load Single Item Funtions
    func LoadItem() {
        if let item = EditOrDelete {
            ProductName.text = item.title
            ProductPrice.text = "\(item.price)"
            ProductDetails.text = item.details
            let image = item.toImage
            ImageTool.image = image?.image as? UIImage
            if  let store = item.toStore {
            var index = 0
            while  index < StoreData.count {
                let row = StoreData[index]
                if row.name == store.name {
                  PickerStoreView.selectRow(index, inComponent: 0, animated: false)
                }
                index = index + 1
                }
            }
            
            
            
        }
    }
    // End Of Load Items
    
    @IBAction func BuBack(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}
