//
//  SwipingViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Constantin on 12/29/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class SwipingViewController: UIViewController {
    
    var displayedUserID = ""
    
    @IBOutlet var imageView: UIImageView!

    func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: view)
        
        let label = gestureRecognizer.view!
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFromCenter = label.center.x - self.view.bounds.width / 2
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200)
        
        let scale = min(abs(100 / xFromCenter), 1)
        
        var stretchAndRotation = rotation.scaledBy(x: scale, y: scale) // rotation.scaleBy(x: scale, y: scale) is now rotation.scaledBy(x: scale, y: scale)
        
        label.transform = stretchAndRotation
        
        
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            
            var acceptedOrRejected = ""
            
            if label.center.x < 100 {
                
                acceptedOrRejected = "rejected"
                
                print("Not chosen")
                
            } else if label.center.x > self.view.bounds.width - 100 {
                
                acceptedOrRejected = "accepted"
                
                print("Chosen")
                
            }
            
            if acceptedOrRejected != "" && displayedUserID != "" {
                
                //update the current user
                PFUser.current()?.addUniqueObjects(from: [displayedUserID], forKey: acceptedOrRejected)
                
                //save
                PFUser.current()?.saveInBackground(block: { (success, error) in
                    self.updateImage()
                })
                
                
                updateImage()
                
                //now add the displayed current user's id (photo's id) to the appropriate location
                
                
            }
            
            rotation = CGAffineTransform(rotationAngle: 0)
            
            stretchAndRotation = rotation.scaledBy(x: 1, y: 1) // rotation.scaleBy(x: scale, y: scale) is now rotation.scaledBy(x: scale, y: scale)
            
            
            label.transform = stretchAndRotation
            
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
            
        }
        
    }

    // get the data off the Parase server
    func updateImage() {
        
        let query = PFUser.query()
        //unrwappig, b/c by the time you get to this page, you already selected the preference
        query?.whereKey("isFemale", equalTo: (PFUser.current()?["isInterestedInWomen"])!)
        
        query?.whereKey("isInterestedInWomen", equalTo: (PFUser.current()?["isFemale"])!)
        
        //now need to determine if we've already accepted or rejected a user - called ignored users
        
        var ignoredUsers = [""]
        
        if let acceptedUsers = PFUser.current()?["accepted"] {
            ignoredUsers += acceptedUsers as! Array
        }
        
        if let rejectedUsers = PFUser.current()?["rejected"] {
            ignoredUsers += rejectedUsers as! Array
        }
        
        query?.whereKey("objectId", notContainedIn: ignoredUsers)
        
        
        let swOfSF: PFGeoPoint = PFUser.current()?["location"] as! PFGeoPoint
    
        query?.whereKey("location", withinGeoBoxFromSouthwest: PFGeoPoint(latitude: swOfSF.latitude - 1, longitude: swOfSF.longitude - 1), toNortheast: PFGeoPoint(latitude: swOfSF.latitude + 1, longitude: swOfSF.longitude + 1))
        
        
        
        query?.limit = 1
        
        query?.findObjectsInBackground(block: { (objects, error) in
            
            //ignore the error if there is one, should add it later.
            
            if let users = objects {
                
                for object in users {
                    
                    if let user = object as? PFUser {
                        
                        self.displayedUserID = user.objectId!
                        
                        
                        //we know it will work as PFFile (force cast), because we saved it as PFFile on the Parase server
                        let imageFile = user["photo"] as! PFFile
                        
                        imageFile.getDataInBackground(block: { (data, error) in
                            
                            if let imageData = data {
                                
                                self.imageView.image = UIImage(data: imageData)
                                
                            }
                            
                            
                        })
                        
                        
                    }
                }
                
            }
            
        })
        
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged(gestureRecognizer:)))
        
        imageView.isUserInteractionEnabled = true
        
        imageView.addGestureRecognizer(gesture)
        
        PFGeoPoint.geoPointForCurrentLocation { (geopoint, error) in
            
            if let geopoint = geopoint {
                
                PFUser.current()?["location"] = geopoint
                
                PFUser.current()?.saveInBackground()
                
            }
            
            
            //print(geopoint)
        }
        
        updateImage()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // takes place whenever. Whenver the segue takes place from this ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "logoutSegue" {
            
            PFUser.logOut()
            
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
