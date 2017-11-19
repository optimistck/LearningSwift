//
//  ViewController.swift
//  Permanent Data Storage
//
//  Created by Constantin on 12/12/16.
//  Copyright © 2016 Constantin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let phoneNumberToStore = "None"
    
    @IBOutlet var textFieldPhone: UITextField!
    
    @IBOutlet var labelStoredPhoneNumber: UILabel!

    @IBAction func buttonAddNumber(_ sender: Any) {
        
        UserDefaults.standard.set(textFieldPhone.text, forKey: "phone number")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let phoneObject = UserDefaults.standard.object(forKey: "phone number")
        if let phone = phoneObject as? String {
            labelStoredPhoneNumber.text = phone
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

/* Original exercise
 
 // Do any additional setup after loading the view, typically from a nib.
 
 //UserDefaults.standard.set("Rob", forKey: "name")
 
 let nameObject = UserDefaults.standard.object(forKey: "name")
 
 //check if object exists and if it's of a certain type. Deals with optionals.
 // Use this if you're not sure if you've used this before.
 
 if let name = nameObject as? String {
 print(name)
 }
 
 // let arr = [1, 2, 3, 4]
 
 //UserDefaults.standard.set(arr, forKey: "array")
 
 let arrayObject = UserDefaults.standard.object(forKey: "array")
 
 if let array = arrayObject as? NSArray {
 print(array)
 }

 
 */
