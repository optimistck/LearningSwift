//
//  ViewController.swift
//  Location Aware
//
//  Created by Constantin on 12/20/16.
//  Copyright © 2016 Constantin. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var lattitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
//        
//        if location.coordinate.latitude != nil {
//            
//        }
        //not needed? Snap?
        
        self.lattitudeLabel.text = String(location.coordinate.latitude)
        self.longitudeLabel.text = String(location.coordinate.longitude)
        self.courseLabel.text = String(location.course)
        self.speedLabel.text = String(location.speed)
        self.altitudeLabel.text = String(location.altitude)

        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            
            if error != nil {
                print(error)
            } else {
                if let placemark = placemark?[0] {
                    var address = ""
                    if placemark.subThoroughfare != nil {
                        address += placemark.subThoroughfare! + " "

                    }
                    
                    if placemark.thoroughfare != nil {
                        address += placemark.thoroughfare! + "\n"
                    }
                    
                    if placemark.subLocality != nil {
                        address += placemark.subLocality! + "\n"
                    }
                    
                    if placemark.subAdministrativeArea != nil {
                        address += placemark.subAdministrativeArea! + "\n"
                    }
                    
                    if placemark.postalCode != nil {
                        address += placemark.postalCode! + "\n"
                    }
                    
                    if placemark.country != nil {
                        address += placemark.country! + "\n"
                    }
                    
                    self.addressLabel.text = address
                    
                }
            }
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

