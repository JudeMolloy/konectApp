//
//  AddDetailsVC.swift
//  KonectApp
//
//  Created by Jude Molloy on 21/02/2018.
//  Copyright © 2018 Jude Molloy. All rights reserved.
//

import UIKit

class AddDetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
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
        
        profilePictureInput.image = UIImage(named: "defaultProfileImage")
        
        
        
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
        
        print("testststtsts")
        
        print(info)
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            print("11111111111")
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            print("222222222")
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            print("ye boi")
            profilePictureInput.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        if displayNameInput.text != nil {
            let displayName = displayNameInput.text
            let jobTitle = displayEmailInput.text
            let sharedEmail = jobTitleInput.text
            let twitter = twitterInput.text
            let facebook = facebookInput.text
            let bio = bioInput.text
            
            let data = ["display name": displayName, "shared email": sharedEmail, "job title": jobTitle, "twitter": twitter, "facebook": facebook, "bio": bio]
            
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
