//
//  UIImageExtensions.swift
//  APIMark2
//
//  Created by MacBook Pro on 17/2/13.
//  Copyright © 2017年 Huang Baoan. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newWidth, height: newHeight)))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
//    static func loadImageForGCS(path: String, complete: @escaping (UIImage) -> Void) {
//        
//        let storage = FIRStorage.storage()
//        let ref = storage.reference()
//        
//        var documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
//        
//        documentPath.append("/\(path)")
//        print(documentPath)
//        
//        if !FileManager.default.isReadableFile(atPath: documentPath) {
//            
//            ref.child(path).write(toFile: URL.init(fileURLWithPath: documentPath)) { (url, err) in
//                
//                if err != nil {
//                    complete(#imageLiteral(resourceName: "LogoFull"))
//                }else {
//                    
//                    DispatchQueue.main.async(execute: {
//                        let image: UIImage = UIImage(contentsOfFile: documentPath)!
//                        complete(image)
//                    })
//                }
//                
//            }
//            
//        }else {
//            
//            DispatchQueue.main.async(execute: {
//                let image: UIImage = UIImage(contentsOfFile: documentPath)!
//                complete(image)
//            })
//            
//        }
//    }
}









