//
//  SecondViewController.swift
//  testAppartoo
//
//  Created by zh ch on 07/04/16.
//  Copyright (c) 2016 Chong. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController, CLLocationManagerDelegate {
    
    var barsArray: [Bar] = []
    
    var indexBar: Int?
    @IBOutlet weak var mapDetail: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonParsingFromFile()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        //GPS postion
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        //read all bars
        makeMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    func makeMap(){
    
        for bar in barsArray{
        
            var latitude = bar.latitude
            var longitude = bar.longitude
            
            var location = CLLocationCoordinate2DMake(latitude!,longitude!)
            
            
            
            var annotation = MKPointAnnotation()
            
            annotation.coordinate = location
            
            annotation.title = bar.name
            
            annotation.subtitle = bar.address
            
            
            mapDetail.addAnnotation(annotation)

        
        
        }
    
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        
        var userLocation : CLLocation = locations[0] as! CLLocation
        locationManager.stopUpdatingLocation()
        
        let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude:  userLocation.coordinate.longitude)
        
        var span = MKCoordinateSpanMake(0.005,0.0005)
        
        var region = MKCoordinateRegionMake(location, span)
        
        mapDetail.setRegion(region,animated:true)
        
    }
    
    

    
    func jsonParsingFromFile(){
        if let path = NSBundle.mainBundle().pathForResource("Pensebete", ofType: "json"){
            if let jsonData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil){
                if let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary{
                    if let bars : NSArray = jsonResult["bars"] as? NSArray{
                        //print(bars)
                        for bar in bars{
                            
                            if let dict = bar as? NSDictionary{
                                
                                var b = Bar(json: dict)
                                
                                barsArray.append(b)
                            }
                        }
                        
                    }
                }
            }
        }
    }

    

}

