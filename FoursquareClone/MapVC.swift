//
//  MapVC.swift
//  FoursquareClone
//
//  Created by Rafi Saar on 11/08/2021.
//  Copyright © 2021 Syncopa Productions. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        // Navigation controller only showed up before Places VC so it didn't know where to put the above Save button, even tough it's written in the MapVC file.  We therefore added a new Navigation controller in front of the MapVC, but then we need to manually add the Back button (at least, this is one solution proposed in the course).
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
    }
    
    @objc func saveButtonClicked() {
        // PARSE
        
    }

    @objc func backButtonClicked() {
        // navigationController?.popViewController(animated: true)  -- won't work because we have another navigation controller in between
        self.dismiss(animated: true, completion: nil)   // will dismiss and go back to where we were previously
    }
    
}
