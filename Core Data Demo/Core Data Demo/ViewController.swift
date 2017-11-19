//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Constantin on 12/21/16.
//  Copyright © 2016 Constantin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        /*
        newUser.setValue("ralphie", forKey: "username")
        newUser.setValue("mypass", forKey: "password")
        newUser.setValue(2, forKey: "age")
 
        
        do {
            try context.save()
            print("Saved")
        } catch {
            print("there was an error")
        }
        */
 
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        // add predicate: only look for certain data with certain properties --- looking for a particular value. Powerful to look for values in DBs. Search for NSpreidcate formats in Google.
        ////request.predicate = NSPredicate(format: "username = %@", "tommy")
        // to search for anyone less than age 10:
        //request.predicate = NSPredicate(format: "age < %@", "10")
        
        // by default when request is run, instead of the values, the device will return faults, useful for testing the structure of the data.
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let username = result.value(forKey: "username") as? String {
                        /*
                        context.delete(result)
                        do {
                            try context.save()
                        } catch {
                            print("delete fialed")
                        }
                        */
                        /*
                        result.setValue("Dooley", forKey: "username")
                        //and now save
                        
                        do {
                            try context.save()
                        } catch {
                            print("rename fialed")
                        }
                        */
                        print(username)
 
                    }
                    
                }
                
            } else {
                print("No results")
            }
            
        } catch {
            print("Couldn't fetch results")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

