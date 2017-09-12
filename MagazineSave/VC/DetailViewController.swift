//
//  DetailViewController.swift
//  MagazineSave
//
//  Created by Ryan Morrison on 12/09/2017.
//  Copyright © 2017 egoDev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var addBtnStyle: UIButton!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    var imgPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgPicker.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        
        addBtnStyle.layer.cornerRadius = 5.0
        addBtnStyle.layer.masksToBounds = true
        addBtnStyle.backgroundColor = UIColor(displayP3Red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        addBtnStyle.setTitleColor(UIColor.white, for: .normal)
        
    }

    
    @IBAction func photosTapped(_ sender: UIBarButtonItem) {
        imgPicker.sourceType = .photoLibrary
        present(imgPicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        imgPicker.sourceType = .camera
        imgPicker.allowsEditing = true
        imgPicker.cameraCaptureMode = .photo
        present(imgPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgView.image = chosenImage
        }
        imgPicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: UIButton) {
       if  let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let item = Item(entity: Item.entity(), insertInto: context)
            item.title = titleTextField.text
        
        if let image = imgView.image {
            if let imgData =  UIImagePNGRepresentation(image) {
                item.image = imgData
        }
        }
            try? context.save()
            navigationController?.popViewController(animated: true)
        }
        
    }
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
