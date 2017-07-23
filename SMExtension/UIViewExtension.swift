//
//  UIViewExtension.swift
//  In
//
//  Created by MacBook Pro on 2017/6/1.
//  Copyright © 2017年 Sweetman, Inc. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Render Layer To Image
extension UIView{
    
    //UIView to UIImage?
    public func renderLayerToImage() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(frame.size, true, 3.0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
        
    }
    
}



