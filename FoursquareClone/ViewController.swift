//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Rafi Saar on 09/08/2021.
//  Copyright © 2021 Syncopa Productions. All rights reserved.
//

import UIKit
import Parse
// import ParseSwift


class ViewController: UIViewController {

    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
/*
        let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "Banana"
        parseObject["calories"] = 150
        parseObject.saveInBackground { (success, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("uploaded")
            }
        }
        
        let query = PFQuery(className: "Fruits")
//        query.whereKey("name", equalTo: "Apple")
        query.whereKey("calories", greaterThan: 120)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print(objects)
            }
 
        }
*/
        
        
        
        
    }

    
    @IBAction func signInClicked(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != "" {
         
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { (user, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error!.localizedDescription)
                } else {
                    
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                    
                }
            }
            
        } else {
            makeAlert(titleInput: "Error", messageInput: "Username or Password is empty!")
        }
    }
 
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != "" {
            
            let user = PFUser()
            user.username = userNameText.text!                      // advantage of Parse.  Firebase cannot add user with username, but e-mail only.  However, it's always better to use the e-mail for future use if needed
            user.password = passwordText.text!
            
            user.signUpInBackground { (success, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error!.localizedDescription)
                } else {
                    
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                    
                }
            }
            
        } else {
            makeAlert(titleInput: "Error", messageInput: "Username or Password is empty!")
        }
        
    }
    
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

