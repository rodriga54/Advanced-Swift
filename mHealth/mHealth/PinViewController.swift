//
//  PinViewController.swift
//  mHealth
//
//  Created by Abe Rodriguez on 4/9/17.
//  Copyright © 2017 ___AbeRodriguez___. All rights reserved.
//

import UIKit

class PinViewController: UIViewController, UITextFieldDelegate {

        // MARK: - Properties
    // when database is created to store pin and version
        //var pinver : PinVersion?
        var pin: String?
        
        // MARK: - Outlets
        
        @IBOutlet weak var pinTextField: UITextField!
        @IBOutlet weak var errorLabel: UILabel!
        
        // MARK: - UIViewController methods
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        func validatePINLocally() -> Bool {
            
            // 1. Make sure PIN is not nil
            guard let pin = self.pin else {
                return false
            }
            
            // 2. Make sure PIN is exactly 6 characters long
            if pin.characters.count != 6 {
                return false
            }
            
            // 3. Make sure first three characters of PIN are uppercase letters
            //    and that last three are decimal digits
            let letters = CharacterSet.uppercaseLetters
            let digits = CharacterSet.decimalDigits
            
            var count = 0
            for uni in pin.unicodeScalars {
                if count < 3 && !letters.contains(uni) {
                    return false
                } else if count >= 3 && !digits.contains(uni) {
                    return false
                }
                count += 1
            }
            
            // 4. If everything is OK, return true
            return true
        }
        
        func validatePINWithServer() -> Bool {
            // TODO - Upload pin and app name to server to verify that it is correct
            
            return true
        }
        
        // MARK: - UITextFieldDelegate methods
        
        
        // Dismiss keyboard when return key is pressed
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        // When keyboard has been dismissed, check for valid PIN and either return or
        // save the validated PIN and segue back to the main menu
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            // 1. Get the PIN from the
            pin = pinTextField.text!
            
            // 2. Check for a valid PIN string
            if !validatePINLocally() {
                errorLabel.text = "Invalid PIN entered. Please try again."
                return
            }
            
            // 3. Send the PIN to the server to be checked
            if !validatePINWithServer() {
                errorLabel.text = "This token is invalid. There are 8 apps, are you using the right one for you?"
                return
            }
            
            // 4. Save the valid PIN
            errorLabel.text = ""
            
            let defaults = UserDefaults.standard
            defaults.set(pin, forKey: "PIN")
            
            // 5. Return to main menu view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let vc = storyboard.instantiateViewController(withIdentifier: "SelectExcercise")
            //show window
            appDelegate.window?.rootViewController = vc
            let vc2 = self.view?.window?.rootViewController
            vc2?.present(vc, animated: true, completion: nil)
            //performSegue(withIdentifier: "DefaultExercise", sender: self)
        }


}
