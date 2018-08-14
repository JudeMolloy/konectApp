//
//  AddDetailsVC.swift
//  KonectApp
//
//  Created by Jude Molloy on 21/02/2018.
//  Copyright © 2018 Jude Molloy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class AddDetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageToUpload: UIImage?
    @IBOutlet weak var profilePictureInput: UIImageView!
    
    @IBOutlet weak var displayNameInput: UITextField!
    
    @IBOutlet weak var displayEmailInput: UITextField!
    
    @IBOutlet weak var jobTitleInput: UITextField!
    
    @IBOutlet weak var twitterInput: UITextField!
    
    @IBOutlet weak var facebookInput: UITextField!
    
    @IBOutlet weak var bioInput: UITextView!
    
    
    //DataService.instance.addExtraInformation(userData: data)

    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        
        
        
        // adds the tap functionality to the image view and calls the handler function
        profilePictureInput.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfilePictureInput)))
        
        // allows the image to be tapped
        profilePictureInput.isUserInteractionEnabled = true

        // Do any additional setup after loading the view.
        
        
    }

    
    
    
    @objc func handleSelectProfilePictureInput() {
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
        
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        

        
        print(info)
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {

            profilePictureInput.image = selectedImage
            self.imageToUpload = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    var data = [String: Any?]()
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        var imageUploadComplete = false
        
        if displayNameInput.text != nil {
            let displayName = displayNameInput.text
            let jobTitle = jobTitleInput.text
            let sharedEmail = displayEmailInput.text
            let twitter = twitterInput.text
            let facebook = facebookInput.text
            let bio = bioInput.text
            
            data = ["displayName": displayName, "sharedEmail": sharedEmail, "jobTitle": jobTitle, "twitter": twitter, "facebook": facebook, "bio": bio, "profileImageURL": "DIDNT UPDATE"]
            
            // Create a unique image name for each uploaded image.
            let imageName = NSUUID().uuidString
            let storageREF = Storage.storage().reference().child("\(imageName).png")
            if let newProfileImage = imageToUpload {
                if let uploadData = UIImagePNGRepresentation(newProfileImage) {
                    storageREF.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                        if error != nil{
                            print(error)
                            return
                        }
                        
                        print(metadata)
                        if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                            self.data.updateValue(profileImageURL, forKey: "profileImageURL")
                            imageUploadComplete = true
                            self.updateData()
                        }
                        
                    })
                }
            }
            
            
            
        }
        
        
    }
    
    func updateData() {
        
        dump(data)
        DataService.instance.addDetailsForUser(values: data as [String : AnyObject])
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarVC")
        self.present(tabBarVC, animated: true, completion: nil)
        
    }
    
//    func addDetailsForUser(uid: String, values: [String: AnyObject]) {
//
//        let ref = FirebaseDatabase.datab
//
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
