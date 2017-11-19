//
//  ViewController.swift
//  Is It Prime
//
//  Created by Constantin on 11/27/16.
//  Copyright © 2016 Constantin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func primeButton(_ sender: Any) {
        
        let number = UInt32(InputField.text!)
        
        var isPrime = true
        
        if number == 1 {
            isPrime = false
        }
        
        var i = 2
        while i < number {
            if number % i == 0 {
                isPrime = false
            }
            i += 1
        }
        
        resultsLabel.text = isPrime.text

        
    }
    @IBOutlet var InputField: UITextField!
    @IBOutlet var resultsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

