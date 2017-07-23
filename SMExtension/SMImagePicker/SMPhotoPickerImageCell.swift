//
//  SMPhotoPickerImageCell.swift
//  SMInstagramPhotosPicker
//
//  Created by MacBook Pro on 2017/4/18.
//  Copyright © 2017年 Sweetman, Inc. All rights reserved.
//

import UIKit

class SMPhotoPickerImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!    
    @IBOutlet weak var mk: UIView!

    var image: UIImage? {
        
        didSet {
            
            imageView.image = image
        }
    }
    
    override var isSelected: Bool {
        didSet{
            if isSelected {
                mk.isHidden = false
            }else{
                mk.isHidden = true
            }
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isSelected = false
        
        // Initialization code
//        
//        imageView.layer.borderWidth = 0.5
//        imageView.layer.borderColor = UIColor.white.cgColor
    }
    
}
