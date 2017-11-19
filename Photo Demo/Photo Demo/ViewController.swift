//
//  ViewController.swift
//  Photo Demo
//
//  Created by Constantin on 12/26/16.
//  Copyright © 2016 Constantin. All rights reserved.
//

import UIKit

//UINavigationControllerDelegate needed since we're almost going to a different app

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        } else {
            print("There was a problem getting image")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBOutlet var imageView: UIImageView!
    @IBAction func importImage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        // change this to camera instead of the library.
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

