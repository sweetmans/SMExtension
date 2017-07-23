//
//  FilterCell.swift
//  Filter
//
//  Created by MacBook Pro on 2017/5/13.
//  Copyright © 2017年 Sweetman, Inc. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    
    weak var filterObject: Filter? {didSet{fil()}}
    
    weak var image: UIImage? {
        didSet{
            smapleImageView.image = image
        }
    }
    
    @IBOutlet weak var smapleImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private func fil(){
        
        if let i = image {
            smapleImageView.image = createFilteredImage(filterName: filterObject!.name, image: i)
        
        }
        
        nameLabel.text = filterObject?.dname
 
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override var isSelected: Bool {
        didSet{
            
            if isSelected {
                nameLabel.textColor = UIColor(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1)
            }else{
                nameLabel.textColor = UIColor.lightGray
            }
        }
    }
    
    fileprivate let context = CIContext(options: nil)
    private func createFilteredImage(filterName: String, image: UIImage) -> UIImage? {

        //handle normal one.
        if filterName == "Normal" {return image}
        
          // 1 - create source image
        let sourceImage = CIImage(image: image)
        
        // 2 - create filter using name
        if let filter = CIFilter(name: filterName) {
            
            if filterObject?.attribute != nil {
                filter.setValuesForKeys(filterObject!.attribute!)
            }else{
                filter.setDefaults()
            }
            
            // 3 - set source image
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            // 4 - output filtered image as cgImage with dimension.
            
            if let output = filter.outputImage{
                if let outputCGImage = context.createCGImage(output, from: output.extent) {
                    return UIImage(cgImage: outputCGImage)
                }
                return nil
            }
        }
        return nil
    }
    
}
