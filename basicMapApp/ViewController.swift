//
//  ViewController.swift
//  basicMapApp
//
//  Created by Devesh Verma on 2020-01-15.
//  Copyright © 2020 Devesh Verma. All rights reserved.
//

import UIKit

import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {

  
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textView: UITextView!
    
    var myAnnotations = [CLLocation]()
    
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        let longGesture = UILongPressGestureRecognizer(target: self,
       action: #selector(addPin(longGesture:)))
        mapView.addGestureRecognizer(longGesture)
    }
    @objc func addPin(longGesture: UIGestureRecognizer) {
        let touchPoint = longGesture.location(in: mapView)
        let touchLocation = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let location = CLLocation(latitude: touchLocation.latitude, longitude: touchLocation.longitude)
        let myAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = touchLocation
        myAnnotation.title = "\(touchLocation.latitude) \(touchLocation.longitude)"
        myAnnotations.append(location)
        self.mapView.addAnnotation(myAnnotation);
        }
    

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    let zoomArea = MKCoordinateRegion(center: self.mapView.userLocation.coordinate, span: MKCoordinateSpan (latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.mapView.setRegion(zoomArea, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let newLocation = locations.last {
    let latitudeString = "\(newLocation.coordinate.latitude)"
    let longitudeString = "\(newLocation.coordinate.longitude)"
        textView.text = "Latitude: " + latitudeString + "\nLongitude: " + longitudeString
    }
        
    }

    @IBAction func clearPins(_ sender: Any) {
        mapView.removeAnnotations(mapView.annotations)
        myAnnotations.removeAll()
        
    }
    
}

