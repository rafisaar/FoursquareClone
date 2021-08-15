//
//  AddPlaceVC.swift
//  FoursquareClone
//
//  Created by Rafi Saar on 11/08/2021.
//  Copyright © 2021 Syncopa Productions. All rights reserved.
//

import UIKit

/* can use global variables to pass on information between classes/views but it's usually not advisable to do so, especially when working with a team, others may change global variable values without us knowing it
 Gloabl variables are declared outside the class and are known to other classes as well.
 if using them, they're defined in this way:

var globalName = ""
var globalType = ""
var globalAtmosphere = ""
 
*/


class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var placeNameText: UITextField!
    @IBOutlet weak var placeTypeText: UITextField!
    @IBOutlet weak var placeAtmosphereText: UITextField!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        nextButton.isEnabled = false
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)

        placeImageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        placeImageView.addGestureRecognizer(imageTapRecognizer)

        
    }
    

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
 //       nextButton.isEnabled = true                        // enable Next button only after user chooses an image
        self.dismiss(animated: true, completion: nil)        // go back to original view controller

    }

    
    @IBAction func nextButtonClicked(_ sender: Any) {
        // globalName = placeNameText.text              -- if we'd use global variables, this is where we would pass on the information to the next VC
        
        if placeNameText.text != "" && placeTypeText.text != "" && placeAtmosphereText.text != "" {
            if let chosenImage = placeImageView.image {             // will only succeed if image was indeed chosen already
                let placeModel = PlaceModel.sharedInstance          // because it has a private intializer, we can only use the single instance
                placeModel.placeName = placeNameText.text!
                placeModel.placeType = placeTypeText.text!
                placeModel.placeAtmosphere = placeAtmosphereText.text!
                placeModel.placeImage = chosenImage
                
                performSegue(withIdentifier: "toMapVC", sender: nil)
            }
            
        } else {
            
            let alert = UIAlertController(title: "Error", message: "Missing info", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    
}
