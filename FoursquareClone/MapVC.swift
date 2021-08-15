//
//  MapVC.swift
//  FoursquareClone
//
//  Created by Rafi Saar on 11/08/2021.
//  Copyright © 2021 Syncopa Productions. All rights reserved.
//

import UIKit
import MapKit
//import CoreLocation
import Parse

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    // var chosenLatitude = ""  -- replaced by entries in the singleton class model to be consistent
    // var chosenLongitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        // Navigation controller only showed up before Places VC so it didn't know where to put the above Save button, even tough it's written in the MapVC file.  We therefore added a new Navigation controller in front of the MapVC, but then we need to manually add the Back button (at least, this is one solution proposed in the course).
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))

        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest       // better accuracy will comsume more battery
        locationManager.requestWhenInUseAuthorization()                 // defines when location will be used - this will request authorization from the user
        locationManager.startUpdatingLocation()                         // don't forget to update Info.plist with information to the user about accessing this data
        
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(myGestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 3                          // will require minimum 3 seconds.  Less than that is too short usually
        mapView.addGestureRecognizer(gestureRecognizer)
        

        
    }
    
    
    @objc func chooseLocation(myGestureRecognizer:UIGestureRecognizer) {
        
        if myGestureRecognizer.state == .began {
            
            let touchedPoint = myGestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
                                    
            let annotation = MKPointAnnotation()                            // creates a pin
            annotation.coordinate = touchedCoordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            self.mapView.addAnnotation(annotation)
            
            PlaceModel.sharedInstance.placeLatitude = String(touchedCoordinates.latitude)
            PlaceModel.sharedInstance.placeLongitude = String(touchedCoordinates.longitude)
            
        }
        
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()          // so that when user changes location in the map it won't invoke this function again
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
    @objc func saveButtonClicked() {
        // PARSE
        
        let placeModel = PlaceModel.sharedInstance
        
        let object = PFObject(className: "Places")
        object["name"] = placeModel.placeName
        object["type"] = placeModel.placeType
        object["atmosphere"] = placeModel.placeAtmosphere
        // object["latitude"] = self.chosenLatitude   --  for consistency, we'll remove those and add 2 more entries to our singleton class model
        // object["longitude"] = self.chosenLongitude
        object["latitude"] = placeModel.placeLatitude
        object["longitude"] = placeModel.placeLongitude
        
        if let imageData = placeModel.placeImage.jpegData(compressionQuality: 0.5) {
            object["image"] = PFFileObject(name: "\(placeModel.placeName).jpg", data: imageData)
        }
        
        object.saveInBackground { (success, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                 
            } else {
                self.performSegue(withIdentifier: "fromMapVCtoPlacesVC", sender: nil)
            }
        }
        
    }

    
    @objc func backButtonClicked() {
        // navigationController?.popViewController(animated: true)  -- won't work because we have another navigation controller in between
        self.dismiss(animated: true, completion: nil)   // will dismiss and go back to where we were previously
    }
    
}
