//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by Rafi Saar on 11/08/2021.
//  Copyright © 2021 Syncopa Productions. All rights reserved.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()            // singleton class - this is going to be the only instance of this class
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    
    private init() {}                                   // only this class can initialize
    
}
