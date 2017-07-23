//
//  SMProgressView.swift
//  SMInstagramPhotosPicker
//
//  Created by MacBook Pro on 2017/4/19.
//  Copyright © 2017年 Sweetman, Inc. All rights reserved.
//

import UIKit

class SMProgressView: UIView {
    
    
    var progress: CGFloat = 0.0 {didSet{updateProgress()}}
    var progressLayer: CAShapeLayer = CAShapeLayer()
    
    override func awakeFromNib() {
        
        progressLayer.lineCap = "round"
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0
        progressLayer.fillColor =   UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 0.56).cgColor
        progressLayer.lineWidth = 3.0
        progressLayer.frame = bounds.insetBy(dx: 6, dy: 6)
        
        progressLayer.path = UIBezierPath(roundedRect: progressLayer.bounds, cornerRadius: progressLayer.bounds.width / 2.0).cgPath
        //progressLayer.path = path.cgPath
        layer.addSublayer(progressLayer)
        
        layer.cornerRadius = 3.0
        
    }
    
    func updateProgress() {
        
        if progress < 0.09 {
            progress = 0.09
        }
        
        progressLayer.strokeEnd = progress
        
    }
    
}
