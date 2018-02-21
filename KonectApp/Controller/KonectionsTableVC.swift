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
            print(snapshot.key)
            let connectionUID = snapshot.key
            
            self.dataREF.REF_USERS.child(connectionUID).observe(.childAdded, with: { (snapshot) in
                
                let user = User()
                
                // fix the vacant space problem by using a database child to store details
                
                if snapshot.key != "connections" {
                    user.email = snapshot.value! as? String
                    print("AAAAA")
                    print(user.email!)
                    print("BBBBB")
                }
                
                self.users.append(user)
                
                DispatchQueue.main.async { self.tableView.reloadData() }
                
                print(snapshot)
                print("OK")
            })
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

