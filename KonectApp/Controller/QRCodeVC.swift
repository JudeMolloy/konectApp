//
//  QRCodeVC.swift
//  KonectApp
//
//  Created by Jude Molloy on 05/02/2018.
//  Copyright © 2018 Jude Molloy. All rights reserved.
//

import UIKit
import Firebase

class QRCodeVC: UIViewController {

    @IBOutlet weak var QRCodeImage: UIImageView!
    
    var currentUserUID = Auth.auth().currentUser?.uid

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func generateQRCode(input: String) {
            
            let data = input.data(using: String.Encoding.ascii)
            
            if let filter = CIFilter(name: "CIQRCodeGenerator") {
                filter.setValue(data, forKey: "inputMessage")
                let transform = CGAffineTransform(scaleX: 3, y: 3)
                
                if let output = filter.outputImage?.transformed(by: transform) {
                    let image = UIImage(ciImage: output)
                    QRCodeImage.image = image
                }
            }
            
        }

            
        generateQRCode(input: currentUserUID!)

        
    }

}

