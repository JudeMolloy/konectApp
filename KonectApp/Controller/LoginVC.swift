//
//  LoginVC.swift
//  KonectApp
//
//  Created by Jude Molloy on 27/01/2018.
//  Copyright © 2018 Jude Molloy. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        if emailField.text != nil && passwordField.text != nil {
            
            AuthService.instance.logInUser(withEmail: emailField.text!, andPassword: passwordField.text!, logInComplete: { (success, loginError) in
                if success {
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarVC")
                    self.present(tabBarVC, animated: true, completion: nil)
                } else {
                    print(String(describing: loginError?.localizedDescription))
                    
                    // Create and display alert to notify user that email or password was incorrect
                    let alertController = UIAlertController(title: "Konect", message: "The email or password you entered was incorrect. Please try again." , preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    
                    // Reset the password field
                    self.passwordField.text = ""
                }
                
                
                
            })
            
        }
    }
    
  
}

extension LoginVC: UITextFieldDelegate { }
