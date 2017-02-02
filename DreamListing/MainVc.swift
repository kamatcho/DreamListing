//
//  MainVc.swift
//  DreamListing
//
//  Created by MOHAMED on 1/27/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import CoreData
class MainVc: UIViewController , UITableViewDelegate , UITableViewDataSource , NSFetchedResultsControllerDelegate {

    @IBOutlet weak var SegmentItemControl: UISegmentedControl!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var controller:NSFetchedResultsController<Item>!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        attempFetch()
        self.tableView.reloadData()
        
    }
    // Start Table Function
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections{
             let sectioninfo = sections[section]
                return sectioninfo.numberOfObjects
            
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    // End Of Table Function
    
    func configureCell(cell:ItemCell , indexPath:IndexPath) {
        
        let singleCell = controller.object(at: indexPath)
        cell.setCell(item:singleCell)
       
        
    }
    // Start Load Data
    func attempFetch(){
        let fetchrequest : NSFetchRequest<Item> = Item.fetchRequest()
        let datesort = NSSortDescriptor(key: "created", ascending: false)
        let titlesort = NSSortDescriptor(key: "title", ascending: true)
        let priceesort = NSSortDescriptor(key: "price", ascending: true)

        if SegmentItemControl.selectedSegmentIndex == 0 {
            fetchrequest.sortDescriptors = [datesort]
        } else if SegmentItemControl.selectedSegmentIndex == 1 {
            fetchrequest.sortDescriptors = [titlesort]

        } else if SegmentItemControl.selectedSegmentIndex == 2 {
           fetchrequest.sortDescriptors = [priceesort]
        }
        
        self.controller = NSFetchedResultsController(fetchRequest: fetchrequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        self.controller.delegate = self

        do {
            try self.controller.performFetch()
        }catch {
            print("error")
        }
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        // data fetch
        switch(type) {
            
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                configureCell(cell: cell, indexPath: indexPath )
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        }
    }    // End Of Load Data
    
    // Edit Or Delet Item
    // Spacify Which Row Is Selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let object = controller.fetchedObjects {
            let item = object[indexPath.row]
            performSegue(withIdentifier: "EditOrDeleteItem", sender: item)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditOrDeleteItem" {
            if let destination = segue.destination as? AddAndEditItem {
                if let item = sender as? Item {
                    destination.EditOrDelete = item
                }
                
            }
        }
    }
    // Sort Data
    
    @IBAction func SortItemData(_ sender: Any) {
        attempFetch()
        tableView.reloadData()
    }

}

