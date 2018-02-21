//
//  ProfileVC.swift
//  KonectApp
//
//  Created by Jude Molloy on 01/02/2018.
//  Copyright © 2018 Jude Molloy. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var jobTitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentUser = Auth.auth().currentUser?.email
        if currentUser != nil {
            jobTitleLabel.text = currentUser
        }
        // Do any additional setup after loading the view.
    }
    

    

    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        
        let currentUserUID = Auth.auth().currentUser?.uid
        
        
        
        // The following code should be used to create the relationship between to users. (Will be called whenever a user scans another users QR code)
        
        DataService.instance.createConnection(user1: currentUserUID!, user2: "nhP1PxMlmlhWmtDFFnc5VhUdAHc2")
        
        // Ends Here
        
        
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        if Auth.auth().currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let startVC = storyboard.instantiateViewController(withIdentifier: "StartVC")
            self.present(startVC, animated: true, completion: nil)
        }
        
    }
    
}
