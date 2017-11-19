//
//  ViewController.swift
//  API Demo
//
//  Created by Constantin on 12/22/16.
//  Copyright © 2016 Constantin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var cityTextField: UITextField!
    @IBAction func submit(_ sender: Any) {
        
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + cityTextField.text!.replacingOccurrences(of: " ", with: "%20") + ",uk&appid=606c8fa7705b822fa1b41f1d9760b661") {
        
        //another way ... task without a request
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error)
            } else {
                if let urlContent = data {
                    
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        print(jsonResult)
                        
                        //Comes out as optional, this means, we need to check to ensure it's there before we use it.
                        print(jsonResult["name"])
                        
                        if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                            print(description)
                            
                            DispatchQueue.main.sync(execute: {
                                self.resultLabel.text = description
                            })
                            
                        }
                        
                    } catch {
                        
                        
                        print("JSON processing failed")
                    }
                }
            }
            
        }
        
        //don't forget!
        task.resume()
        } else {
            resultLabel.text = "Couldn't find the weather for that city. Please try another."
        }
        
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

