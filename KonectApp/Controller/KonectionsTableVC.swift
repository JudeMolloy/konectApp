//
//  KonectionsTableVC.swift
//  KonectApp
//
//  Created by Jude Molloy on 17/02/2018.
//  Copyright © 2018 Jude Molloy. All rights reserved.
//

import UIKit
import Firebase

class KonectionsTableVC: UITableViewController {
    
    let dataREF = DataService.instance
    
    let cellId = "cellId"
    
    var users = [User]()
    
    let currentUserUID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        fetchUsers()
        self.tableView.reloadData()
        
    }
    
    func fetchUsers() {
        dataREF.REF_USERS.child(currentUserUID!).child("connections").observe(.childAdded) { (snapshot) in
            let connectionUID = snapshot.key
            
            let query = self.dataREF.REF_USERS.child(connectionUID).child("details").queryOrdered(byChild: "displayName")
            var dictionary = [String: AnyObject]()
            
            query.observe(.value) { (snapshot) in
                for child in snapshot.children.allObjects as! [DataSnapshot] {
                    dictionary.updateValue(child.value as AnyObject, forKey: child.key)
                    
                    

                }
             
 
                
                let user = User()
                
                user.displayName = dictionary["displayName"] as? String ?? "Display name not found"
                user.jobTitle = dictionary["jobTitle"] as? String ?? "Job title not found"
                user.sharedEmail = dictionary["sharedEmail"] as? String ?? "Email not found"
                user.profileImageURL = dictionary["profileImageURL"] as? String ?? "https://firebasestorage.googleapis.com/v0/b/konect-u.appspot.com/o/30A008CD-B4E6-414A-A7DC-B633ACBC5BEB.png?alt=media&token=d68e850f-b4cd-42d4-8d7a-7ef18a5ebfdd"
                
                self.users.append(user)
                
                DispatchQueue.main.async { self.tableView.reloadData() }
//                    if let value = child.value as? NSDictionary {
//                        let user = User()
//                        let name = value["name"] as? String ?? "Name not found"
//                        let email = value["email"] as? String ?? "Email not found"
//                        self.users.append(user)
//                        print(user)
//                        DispatchQueue.main.async { self.tableView.reloadData() }
//                    }
                
            }
//            self.dataREF.REF_USERS.child(connectionUID).child("details").observe(.childAdded, with: { (snapshot) in
//
//                for child in snapshot.children.allObjects as! [DataSnapshot] {
//                    if let value = child.value as? NSDictionary {
//                        let user = User()
//                        let name = value["displayName"] as? String
//                    }
//                }
//                if let dictionary = snapshot.value as? [String: AnyObject] {
//                    let user = User()
//                    user.setValuesForKeys(dictionary)
//                    self.users.append(user)
//                    print(user.displayName!)
//                }
//
                
                DispatchQueue.main.async { self.tableView.reloadData() }
                

//            })
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        cell.imageView?.image = UIImage(named: "defaultProfileImage")
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.displayName
        cell.detailTextLabel?.text = user.jobTitle
        

        
        if user.profileImageURL != "nil" {
            if let profileImageURL = user.profileImageURL {

                let url = URL(string: profileImageURL)

                URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in

                        if error != nil {
                            print(error)
                            return
                        }

                        DispatchQueue.main.async {
                            cell.imageView?.layer.cornerRadius = 10
                            cell.imageView?.image = UIImage(data: data!)
                        }

                    }).resume()
                
            }
        }
        
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func fetchUsers() {
//        dataREF.REF_USERS.child(currentUserUID!).child("connections").observe(.childAdded) { (snapshot) in
//            print(snapshot.key)
//            let connectionUID = snapshot.key
//
//            self.dataREF.REF_USERS.child(connectionUID).child("details").observe(.childAdded, with: { (snapshot) in
//
//                let user = User()
//
//                // fix the vacant space problem by using a database child to store details
//
//                user = snapshot.value! as? String
//
//
//                print(user)
//
//                DispatchQueue.main.async { self.tableView.reloadData() }
//
//                print(snapshot)
//                print("OK")
//            })
//
//        }
//    }
    
}

