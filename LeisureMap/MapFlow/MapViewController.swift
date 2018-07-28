//
//  MapViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/25.
//  Copyright © 2018年 tripim. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController ,CLLocationManagerDelegate , MKMapViewDelegate {

    @IBOutlet weak var mapview: MKMapView!
    
    let locationManager = CLLocationManager()
    
    let regionRadius : CLLocationDistance = 1000
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        
        if CLLocationManager.locationServicesEnabled(){
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
        }
        
        
        
        mapview.delegate = self
        mapview.showsUserLocation = true
        
        //centerMapOnLocation

    }
    
    func  centerMapOnLocation(location : CLLocation){
        
        let  coordinateRegion = MKCoordinateRegionMakeWithDistance( location.coordinate, regionRadius , regionRadius )
     
        mapview.setRegion(coordinateRegion, animated: true)
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManger(_ manager: CLLocationManager ,didUpdateLocations  locations:[CLLocation]){
        
        guard let locValue : CLLocationCoordinate2D = manager.location?.coordinate   else {
            return
            
        }
        
        print("latitude:\(locValue)")
        
        centerMapOnLocation(location:manager.location! )
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
