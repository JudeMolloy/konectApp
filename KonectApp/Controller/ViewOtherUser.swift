//
//  ViewOtherUser.swift
//  KonectApp
//
//  Created by Jude Molloy on 29/08/2018.
//  Copyright © 2018 Jude Molloy. All rights reserved.
//


import UIKit
import Firebase

class ViewOtherUser: UIViewController {
    
    let dataREF = DataService.instance
    
    var currentUserUID = Auth.auth().currentUser?.uid
    
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var facebookLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // need to fix the button that is shown
        
        fetchUserDetails()
        
        // Do any additional setup after loading the view.
    }
    
    func fetchUserDetails() {
        
        let user = User()
        
        dataREF.REF_USERS.child(currentUserUID!).child("details").observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                
                user.displayName = value["displayName"] as? String ?? "Display name not found"
                user.jobTitle = value["jobTitle"] as? String ?? "Job title not found"
                user.sharedEmail = value["sharedEmail"] as? String ?? "Email not found"
                user.bio = value["bio"] as? String ?? "Bio not found"
                user.facebook = value["facebook"] as? String ?? "Facebook not found"
                user.twitter = value["twitter"] as? String ?? "Twitter not found"
                user.profileImageURL = value["profileImageURL"] as? String ?? "https://firebasestorage.googleapis.com/v0/b/konect-u.appspot.com/o/30A008CD-B4E6-414A-A7DC-B633ACBC5BEB.png?alt=media&token=d68e850f-b4cd-42d4-8d7a-7ef18a5ebfdd"
                
                
                
                if user.displayName != nil {
                    self.nameLabel.text = user.displayName
                }
                
                if user.jobTitle != nil {
                    self.jobTitleLabel.text = user.jobTitle
                }
                
                if user.bio != nil {
                    self.biographyLabel.text = user.bio
                }
                
                if user.twitter != nil {
                    self.twitterLabel.text = "@" + user.twitter!
                }
                
                if user.facebook != nil {
                    self.facebookLabel.text = user.facebook
                }
                
                if user.sharedEmail != nil {
                    self.emailLabel.text = user.sharedEmail
                }
                
                
                
                
                if user.profileImageURL != nil {
                    
                    let url = URL(string: user.profileImageURL!)
                    //            I AM HERE,    I NEED TO GET THE PROFILE IMAGE USING A SNAPSHOT
                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        
                        if error != nil {
                            print(error)
                            return
                        }
                        
                        DispatchQueue.main.async {
                            self.profileImage?.image = UIImage(data: data!)
                            self.profileImage?.layer.cornerRadius = 10
                        }
                        
                    }).resume()
                    
                }
            }
        }
        
        
        
        
        
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
