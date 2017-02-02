//
//  AddStoreController.swift
//  DreamListing
//
//  Created by MOHAMED on 1/28/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import CoreData

class AddStoreController: UIViewController {
    @IBOutlet weak var StoreNameTxt: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddStoreBtn(_ sender: Any) {
        let store = Store(context: context)
        store.name = StoreNameTxt.text
        do
        {
            ad.saveContext()
            print("Saved")
            StoreNameTxt.text = ""
        } 
        
    }


    @IBAction func BackButon(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
