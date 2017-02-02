//
//  ItemCell.swift
//  DreamListing
//
//  Created by MOHAMED on 1/28/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import CoreData
class ItemCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(item:Item) {
        title.text = item.title
        
        thumb.image = item.toImage?.image as? UIImage
        details.text = item.details
        price.text = "\(item.price)"
    }
 
}
