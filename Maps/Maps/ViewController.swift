//
//  ViewController.swift
//  Maps
//
//  Created by Constantin on 12/20/16.
//  Copyright © 2016 Constantin. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var map: MKMapView!
    
    internal func india () {
        let latitude: CLLocationDegrees = 27.1
        let longitude: CLLocationDegrees = 78.0
        let lanDelta: CLLocationDegrees = 0.05
        let longDelta: CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: lanDelta, longitudeDelta: longDelta)
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        map.setRegion(region, animated: true)
    }
    
    
    internal func house() {
        let latitude: CLLocationDegrees = 38.8958386
        let longitude: CLLocationDegrees = -77.1524537
        let latDelta: CLLocationDegrees = 0.05
        let longDetla: CLLocationDegrees = 0.05
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDetla)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let latitude: CLLocationDegrees = 40.7
//        
//        let longitude: CLLocationDegrees = -73.9
//        
//        let latDelta: CLLocationDegrees = 0.05
//        
//        let lonDelta: CLLocationDegrees = 0.05
//        
//        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
//        
//        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        
//        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        let latitude: CLLocationDegrees = 27.175244
        let longitude: CLLocationDegrees = 80.399773
        let lanDelta: CLLocationDegrees = 0.05
        let longDelta: CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: lanDelta, longitudeDelta: longDelta)
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        map.setRegion(region, animated: true)
        
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.title = "Taj Mahal"
        
        annotation.subtitle = "One day I'll go there..."
        
        annotation.coordinate = coordinates
        
        map.addAnnotation(annotation)
        
        
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longpress(gestureRecognizer:)))
        
        uilpgr.minimumPressDuration = 2
        
        map.addGestureRecognizer(uilpgr)
        

    }
    
    
    func longpress(gestureRecognizer: UIGestureRecognizer) {
        
        let touchPoint = gestureRecognizer.location(in: self.map) //location that wer get in the map
        
        let coordinate = map.convert(touchPoint, toCoordinateFrom: self.map) //map does the conerting for us. It knows where the long press occurred
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = coordinate
        
        annotation.title = "NEw Place"
        
        annotation.subtitle = "May be go here too"
        
        map.addAnnotation(annotation)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

