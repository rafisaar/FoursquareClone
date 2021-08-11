//
//  PlacesVC.swift
//  FoursquareClone
//
//  Created by Rafi Saar on 11/08/2021.
//  Copyright © 2021 Syncopa Productions. All rights reserved.
//

import UIKit

class PlacesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
     
    }
    
    @objc func addButtonClicked() {
        // Segue
        
    }
    
    
}
