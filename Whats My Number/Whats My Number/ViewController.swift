//
//  ViewController.swift
//  Whats My Number
//
//  Created by Constantin on 12/12/16.
//  Copyright © 2016 Constantin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var numberField: UITextField!
    
    
    @IBAction func save(_ sender: Any) {
        UserDefaults.standard.set(numberField.text, forKey:"number")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let numberObject = UserDefaults.standard.object(forKey: "number")
        if let number = numberObject as? String {
            numberField.text = number
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

