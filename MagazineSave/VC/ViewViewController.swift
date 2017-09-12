//
//  ViewViewController.swift
//  MagazineSave
//
//  Created by Ryan Morrison on 12/09/2017.
//  Copyright © 2017 egoDev. All rights reserved.
//

import UIKit

class ViewViewController: UIViewController {

    var preVC = CollectionTableViewController()
    var selectItems: Item?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        titleLabel.text = selectItems?.title?.capitalized
        
        if let imgData = selectItems?.image {
            imgView?.image = UIImage(data: imgData)
        }
        
    }

    @IBAction func deleteBtn(_ sender: UIBarButtonItem) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let theItem = selectItems {
                context.delete(theItem)
                try? context.save()
                navigationController?.popViewController(animated: true)
            }
            
        }
    }
    

}

