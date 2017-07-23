//
//  SMImagePicker.swift
//  SMInstagramPhotosPicker
//
//  Created by MacBook Pro on 2017/5/18.
//  Copyright © 2017年 Sweetman, Inc. All rights reserved.
//

import UIKit

@objc public protocol SMImagePickerDelegate {
    
    func smImagePickerDidFinishPickingImage(smImagePicker: SMImagePicker, image: UIImage, info: [String: Any])
    
    @objc optional func smImagePickerDidEnableFilterMode(smImagePicker: SMImagePicker) -> Bool
    
    @objc optional func smImagePickerDidCancelPickingImage(smImagePicker: SMImagePicker)
}

public class SMImagePicker: UINavigationController {

    public weak var pickerDelegate: SMImagePickerDelegate? = nil {didSet{updateDelegate()}}
    
    private var isEnableFilterMode: Bool = false
    
    private var picker: SMPhotoPickerViewController?
    
    public static var main: SMImagePicker? = {
        
        let b = Bundle(for: SMImagePicker.classForCoder())
        let sb = UIStoryboard(name: "Picker", bundle: b)
        return sb.instantiateInitialViewController() as? SMImagePicker
        
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        if let p = self.visibleViewController as? SMPhotoPickerViewController {
            picker = p
            picker?.filterMode = isEnableFilterMode
            picker?.delegate = self
        }
        
    }


    private func updateDelegate() {
        
        if let enable = pickerDelegate?.smImagePickerDidEnableFilterMode?(smImagePicker: self) {
            isEnableFilterMode = enable
        }
    }
    
    
    deinit {
        print("\(#file): Deinit")
    }
}



extension SMImagePicker: SMPhotoPickerViewControllerDelegate {
    
    public func didFinishPickingPhoto(image: UIImage, meteData: [String : Any]) {
        
        pickerDelegate?.smImagePickerDidFinishPickingImage(smImagePicker: self, image: image, info: meteData)
        
    }

    public func didCancelPickingPhoto() {
        
        if let d = pickerDelegate {
            d.smImagePickerDidCancelPickingImage?(smImagePicker: self)
        }
        
    }
}



