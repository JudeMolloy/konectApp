//
//  AuthService.swift
//  KonectApp
//
//  Created by Jude Molloy on 12/01/2018.
//  Copyright © 2018 Jude Molloy. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            
            let userData = ["email": user.email, ]
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            userCreationComplete(true, nil)
            
        }
    }
    
    func logInUser(withEmail email: String, andPassword password: String, logInComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                logInComplete(false, error)
                return
            }
            logInComplete(true, nil)
        }
        
    }
}
