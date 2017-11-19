//
//  ViewController.swift
//  Log In Demo
//
//  Created by Constantin on 12/21/16.
//  Copyright © 2016 Constantin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var label: UILabel!
    @IBAction func logOut(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        //get everything from Core Data
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        do {
            // reuslt of running the feth request on the context
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    context.delete(result)
                
                    do {
                        try context.save()
                    } catch {
                        print("individual delete failed")
                    }
                    
                }
                label.alpha = 0
                logout.alpha = 0
                textField.alpha = 1
                logInButton.setTitle("Login", for: [])
                isLoogedIn = false
            }
        } catch {
            print("Delete failed")
        }
        
    }
    @IBOutlet var logout: UIButton!
    @IBOutlet var logInButton: UIButton!
    
    var isLoogedIn = false
    
    @IBAction func logIn(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        if isLoogedIn {
            //update user nmae
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            //no predicates, because we want all the results
            //no need to prevent faults, because we're not returning the results
            
            do {
                
                let results = try context.fetch(request)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        result.setValue(textField.text, forKey: "name")
                        
                        do {
                            try context.save()
                        } catch {
                            print("Update user name save failed")
                        }
                        
                    }
                    label.text = "Hi there  " + textField.text! + "!!!"
                }
                
            } catch {
                print("Update username failed")
            }
            
        } else { //set the user name
            let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
            
            newValue.setValue(textField.text, forKey: "name")
            
            do {
                
                try context.save()
                
                //textField.alpha = 0
                
                //logInButton.alpha = 0
                
                logInButton.setTitle("Update username", for: [])
                
                label.alpha = 1
                
                label.text = "Hi there " + textField.text! + "!"
                
                isLoogedIn = true
                
                
            } catch {
                
                print("Failed to save")
                
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject] {
                
                if let username = result.value(forKey: "name") as? String {
                    
                    //textField.alpha = 0
                    
                    logInButton.setTitle("Update username", for: [])
                    
                    logout.alpha = 1
                    
                    label.alpha = 1
                    
                    label.text = "Hi there " + username + "!"
                    
                    logout.alpha = 1
                    
                }
                
            }
            
        } catch {
            print("request failed")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

