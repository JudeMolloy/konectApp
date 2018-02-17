//
//  CreateAccountVC.swift
//  KonectApp
//
//  Created by Jude Molloy on 27/01/2018.
//  Copyright © 2018 Jude Molloy. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
        
        if emailField.text != nil && passwordField != nil {
            
            // Add any more input validation in here
            AuthService.instance.registerUser(withEmail: emailField.text!, andPassword: passwordField.text!, userCreationComplete: { (success, registrationError) in
                if success {
                    
                    // Log in user
                    AuthService.instance.logInUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, logInComplete: { (success, nil) in
                            self.dismiss(animated: true, completion: nil)
                            print("Successfully registered user")
                    })
                    
                } else {
                    print(String(describing: registrationError?.localizedDescription))
                    
                    let alertController = UIAlertController(title: "Konect", message: String(describing: registrationError?.localizedDescription) , preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
            })
            
        }
        
    }
    

}
