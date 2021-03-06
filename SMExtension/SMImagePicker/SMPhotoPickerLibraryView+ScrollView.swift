//
//  SMPhotoPickerLibraryView+ScrollView.swift
//  SMInstagramPhotosPicker
//
//  Created by MacBook Pro on 2017/4/20.
//  Copyright © 2017年 Sweetman, Inc. All rights reserved.
//

import Foundation
import UIKit

extension SMPhotoPickerLibraryView {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == scrollView {
            squareMask.isHidden = false
            
            //print("Off Set:", scrollView.contentOffset)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == scrollView{
            squareMask.isHidden = true
            scaleRect = CGRect(origin: scrollView.contentOffset, size: scrollView.frame.size)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == scrollView{
            squareMask.isHidden = true
            scaleRect = CGRect(origin: scrollView.contentOffset, size: scrollView.frame.size)
        }
        
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView == scrollView {
            squareMask.isHidden = false
        }
    }
    
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
        if scrollView == scrollView{
            //print(scale)
            self.scale = scale
            squareMask.isHidden = true
            scaleRect = CGRect(origin: scrollView.contentOffset, size: scrollView.frame.size)
        }
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}


