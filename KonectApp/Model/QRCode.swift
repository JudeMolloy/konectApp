//
//  QRCodeReader.swift
//  KonectApp
//
//  Created by Jude Molloy on 06/02/2018.
//  Copyright © 2018 Jude Molloy. All rights reserved.
//

import Foundation

class QRCode {
    
    static let instance = QRCode()
    
    
    func generateQRCode(uid: String) {
        
        let data = uid.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                let image = UIImage(ciImage: output)
        
        return image
            }
        }
    }
    
}
