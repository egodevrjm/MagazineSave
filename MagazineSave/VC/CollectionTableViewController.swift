//
//  CollectionTableViewController.swift
//  MagazineSave
//
//  Created by Ryan Morrison on 12/09/2017.
//  Copyright © 2017 egoDev. All rights reserved.
//

import UIKit

class CollectionTableViewController: UITableViewController {
    
   var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    func getData() {
    if  let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        if let itemData = try? context.fetch(Item.fetchRequest()) as? [Item] {
            if let dataItems = itemData {
               items = dataItems
                tableView.reloadData()
            }
        }
    }
    
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let item = items[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Futura", size: 30)
        cell.textLabel?.text = item.title?.capitalized
        
        if let imgData = item.image {
          cell.imageView?.image = UIImage(data: imgData)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        performSegue(withIdentifier: "seg", sender: item)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
              let item = items[indexPath.row]
                   context.delete(item)
                    try? context.save()
                    getData()
                }
            }
    }
         
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewVC = segue.destination as? ViewViewController {
            viewVC.preVC = self
            if let sndItem = sender as? Item {
                viewVC.selectItems = sndItem
                viewVC.preVC = self
            }
        }
        
        
    }
    

}
