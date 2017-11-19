//
//  RiderViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Constantin on 1/7/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
import MapKit

class RiderViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    func displayAlert(title: String, message: String) {
        
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertcontroller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertcontroller, animated: true, completion: nil)
        
    }
    
    var locationManager = CLLocationManager()
    
    var riderRequestActive = true
    
    var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    @IBOutlet var map: MKMapView!
    @IBOutlet var callAnUberButton: UIButton!
    
    @IBAction func callAnUber(_ sender: Any) {
        
        if riderRequestActive {
            
            self.callAnUberButton.setTitle("Call An Uber", for: [])
            
            riderRequestActive = false
            
            let query = PFQuery(className: "RiderRequest")
            
            query.whereKey("username", equalTo: (PFUser.current()?.username)!)
            
            query.findObjectsInBackground(block: { (objects, error) in
                
                if let riderRequests = objects {
                    
                    for riderRequest in riderRequests {
                        
                        riderRequest.deleteInBackground()
                            
                    }
                        
                    }
                    
                    /* *** This is good to know in case we're not sure if the object is casted right. Else, can have a short cut. As above.
                     for object in riderRequests {
                     
                     if let riderRequest = object as? PFObject {
                     
                     riderRequest.deleteInBackground()
                     
                     }
                     
                     }
                    */
                
                
            })
            
        } else {
        
        
        if userLocation.longitude != 0 && userLocation.latitude != 0 {
            
            riderRequestActive = true
        
            let riderRequest = PFObject(className: "RiderRequest")
        
            riderRequest["username"] = PFUser.current()?.username
        
            riderRequest["location"] = PFGeoPoint(latitude: userLocation.latitude, longitude: userLocation.longitude)
            
            riderRequest.saveInBackground(block: { (success, error) in
                
                if success {
                    
                    print("Called an uber")
                    
                    self.callAnUberButton.setTitle("Cancel Uber", for: [])
                    
                } else {
                    
                    self.callAnUberButton.setTitle("Call An Uber", for: [])
                    
                    self.riderRequestActive = false
                    
                    self.displayAlert(title: "Couldn't call Uber", message: "Please try again")
                    
                }
                
            })
        } else {
            
            displayAlert(title: "Couldn't call uber", message: "couldn't detect location")
            
        }
            
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutSegue" {
            
            locationManager.stopUpdatingLocation()
            
            PFUser.logOut()
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        callAnUberButton.isHidden = true
        
        let query = PFQuery(className: "RiderRequest")
        
        query.whereKey("username", equalTo: (PFUser.current()?.username)!)
        
        query.findObjectsInBackground(block: { (objects, error) in
            
            if let objects = objects {
                
                if objects.count > 0 {
                
                    self.riderRequestActive = true
                
                    self.callAnUberButton.setTitle("Cancel Uber", for: [])
                }
                
            }   
            
            self.callAnUberButton.isHidden = false
            
        })
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //different way to do it.
        if let location = manager.location?.coordinate {
            
            userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            
            let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.map.setRegion(region, animated: true)
            
            //make more precise. put pin. Location center of the map
            
            self.map.removeAnnotations(self.map.annotations)
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = userLocation
            
            annotation.title = "Your Location"
            
            self.map.addAnnotation(annotation)
            
            
            let query = PFQuery(className: "RiderRequest")
            
            query.whereKey("username", equalTo: (PFUser.current()?.username)!)
            
            query.findObjectsInBackground(block: { (objects, error) in
                
                if let riderRequests = objects {
                    
                    for riderRequest in riderRequests {
                        
                        riderRequest["location"] = PFGeoPoint(latitude: self.userLocation.latitude, longitude: self.userLocation.longitude)
                        
                        riderRequest.saveInBackground()
                        
                    }
                    
                }
                
            })
            
            
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
