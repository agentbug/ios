//
//  barMap.swift
//  testAppartoo
//
//  Created by zh ch on 07/04/16.
//  Copyright (c) 2016 Chong. All rights reserved.
//


import UIKit
import CoreLocation
import MapKit

class BarMap: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mapBar: MKMapView!
    
    var locationManager = CLLocationManager()
    
    var bar: Bar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //print(bar?.longitude)
        
        
        //GPS position
        self.locationManager.requestAlwaysAuthorization()
        
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        //read bar location
        makeLocation()
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recrea
        
    }
    
    //make bar location
    func makeLocation(){
        var latitude = bar?.latitude
        var longitude = bar?.longitude
        
        var location = CLLocationCoordinate2DMake(latitude!,longitude!)
        
        
        
        var annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        
        annotation.title = bar?.name
        
        annotation.subtitle = bar?.address
        
        
        mapBar.addAnnotation(annotation)
        //mapBar.setRegion(region,animated: true)
        
    }
    

    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        
        var userLocation : CLLocation = locations[0] as! CLLocation
        locationManager.stopUpdatingLocation()
        
        let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude:  userLocation.coordinate.longitude)
       
        var span = MKCoordinateSpanMake(0.005,0.0005)
        
        var region = MKCoordinateRegionMake(location, span)
        
        mapBar.setRegion(region,animated:true)
        
    }

    
}
