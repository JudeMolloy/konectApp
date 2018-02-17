//
//  DataService.swift
//  KonectApp
//
//  Created by Jude Molloy on 03/01/2018.
//  Copyright © 2018 Jude Molloy. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    // creates instance of the class inside itself
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    

    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    
    func createDBUser(uid: String, userData: Dictionary<String,Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func createConnection(user1: String, user2: String) {
        // Creates the relationship between two users
        
        // Access the connections node for user 1
        let REF_USER1 = REF_USERS.child(user1)
        let REF_CONNECTION1 = REF_USER1.child("connections")
        
        // Add the user ID (UID) of the second user to the connections node of the first users record
        REF_CONNECTION1.child(user2).setValue(true)
        
        // Access the connections node for user 2
        let REF_USER2 = REF_USERS.child(user2)
        let REF_CONNECTION2 = REF_USER2.child("connections")
        
        // Add the user ID (UID) of the first user to the connections node of the second users record
        REF_CONNECTION2.child(user1).setValue(true)
    }
    
}
