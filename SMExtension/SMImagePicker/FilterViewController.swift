//
//  FilterViewController.swift
//  Filter
//
//  Created by MacBook Pro on 2017/5/13.
//  Copyright © 2017年 Sweetman, Inc. All rights reserved.
//

import UIKit
import CoreImage


class Filter {
    
    var name: String
    var attribute: [String: Any]?
    var dname: String
    
    
    init(name: String, dname: String, att: [String: Any]? = nil) {
        self.name = name
        self.attribute = att
        self.dname = dname
    }
    
    
}

class FilterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getFilters()
    }
    
    var thumbImage: UIImage?
    var filterN: String = "Normal"
    
    var image: UIImage? {
        didSet{
            thumbImage = UIImage.resizeImage(image: image!, newWidth: 112 * 3)
        }
    }
    var info: [String: Any]?
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        item.tintColor = UIColor.black
        navigationItem.backBarButtonItem = item
    }
    
    
    @IBAction func next(_ sender: UIBarButtonItem) {
        
        if let p = navigationController as? SMImagePicker {
            if let i = imageView.image {
                if var ifo = info {
                    ifo["filter"] = filterN
                    p.pickerDelegate?.smImagePickerDidFinishPickingImage(smImagePicker: p, image: i, info: ifo)
                    p.dismiss(animated: true, completion: nil)
                    p.popToRootViewController(animated: false)
                }
            }
        }
    }
    
    
    var filters = [Filter]()
    //BarHidden Status
    override var prefersStatusBarHidden: Bool {return true}
    
}

//<Mark> Filters

extension FilterViewController {
    
    
    func getFilters(){
        
        
        //Normal One
        let normal = Filter(name: "Normal", dname: "Normal")
        filters.append(normal)
        
        //CIColorClamp
        let clamp = ["inputMinComponents": CIVector(x: 0.01, y: 0.25, z: 0.36, w: -0.18), "inputMaxComponents": CIVector(x: 0.92, y: 0.72, z: 0.65, w: 0.83)]
        let clampFilter = Filter(name: "CIColorClamp", dname: "Clamp", att: clamp)
        filters.append(clampFilter)
        
        //CIColorPolynomial
        let polynomial = ["inputRedCoefficients": CIVector(x: 0.16, y: 1.13, z: 0.11, w: 0),
                          "inputGreenCoefficients": CIVector(x: 0.12, y: 0.75, z: 0.17, w: 0.34),
                          "inputBlueCoefficients": CIVector(x: 0.28, y: 1.19, z: 0.16, w: 0),
                          "inputAlphaCoefficients": CIVector(x: 0, y: 0.8, z: 0, w: 0.14)]
        let polynominalFilter = Filter(name: "CIColorPolynomial", dname: "Polynomial", att: polynomial)
        filters.append(polynominalFilter)
        
        //CIColorMonochrome
        let monochrome = ["inputColor": CIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1),
                          "inputIntensity": NSNumber.init(value: 0.5)] as [String : Any]
        let monochromeFilter = Filter(name: "CIColorMonochrome", dname: "Monochrome", att: monochrome)
        filters.append(monochromeFilter)
        
        //CIColorPosterize
        let posterize = ["inputLevels": NSNumber.init(value: 9.28)] as [String : Any]
        let posterizeFilter = Filter(name: "CIColorPosterize", dname: "Posterize", att: posterize)
        filters.append(posterizeFilter)
        
        //CIFalseColor
        let falseColor = ["inputColor0": CIColor(red: 112/255.0, green: 2/255.0, blue: 164/255.0, alpha:1),
                          "inputColor1": CIColor(red: 255/255.0, green: 255/255.0, blue: 218/255.0, alpha: 1)] as [String : Any]
        let falseColorFilter = Filter(name: "CIFalseColor", dname: "FalseColor", att: falseColor)
        filters.append(falseColorFilter)
        
        //CIMaximumComponent
        let maximumComponentFilter = Filter(name: "CIMaximumComponent", dname: "MaxComponent", att: nil)
        filters.append(maximumComponentFilter)
        
        //CIMinimumComponent
        let minimumComponentFilter = Filter(name: "CIMinimumComponent", dname: "MinComponent", att: nil)
        filters.append(minimumComponentFilter)
        
        //CIPhotoEffectChrome
        let photoEffectChromeFilter = Filter(name: "CIPhotoEffectChrome", dname: "Chrome", att: nil)
        filters.append(photoEffectChromeFilter)
        
        //CIPhotoEffectFade
        let photoEffectFadeFilter = Filter(name: "CIPhotoEffectFade", dname: "Fade", att: nil)
        filters.append(photoEffectFadeFilter)
        
        //Instant
        let photoEffectInstantFilter = Filter(name: "CIPhotoEffectInstant", dname: "Instant", att: nil)
        filters.append(photoEffectInstantFilter)
        
        //Mono
        let photoEffectMonoFilter = Filter(name: "CIPhotoEffectMono", dname: "Mono", att: nil)
        filters.append(photoEffectMonoFilter)
        
        //Noir
        let photoEffectNoirFilter = Filter(name: "CIPhotoEffectNoir", dname: "Noir", att: nil)
        filters.append(photoEffectNoirFilter)
        
        //Process
        let photoEffectProcessFilter = Filter(name: "CIPhotoEffectProcess", dname: "Process", att: nil)
        filters.append(photoEffectProcessFilter)
        
        //Tonal
        let photoEffectTonalFilter = Filter(name: "CIPhotoEffectTonal", dname: "Tonal", att: nil)
        filters.append(photoEffectTonalFilter)
        
        //Transfer
        let photoEffectTransferFilter = Filter(name: "CIPhotoEffectTransfer", dname: "Transfer", att: nil)
        filters.append(photoEffectTransferFilter)
        
        //CIVignette
        let vignette = ["inputRadius": NSNumber.init(value: 2),
                        "inputIntensity": NSNumber.init(value: 1)] as [String : Any]
        let vignetteFilter = Filter(name: "CIVignette", dname: "Vignette", att: vignette)
        filters.append(vignetteFilter)
        
        //CIDotScreen
        let dotScreenFilter = Filter(name: "CIDotScreen", dname: "Dot Screen", att: nil)
        filters.append(dotScreenFilter)
        
        //CICMYKHalftone
        let CMYKHalftoneFilter = Filter(name: "CICMYKHalftone", dname: "Half Tone", att: nil)
        filters.append(CMYKHalftoneFilter)
        
        //CISRGBToneCurveToLinear
        let sRGBToneCurveToLinearFilter = Filter(name: "CISRGBToneCurveToLinear", dname: "sRGB Tone", att: nil)
        filters.append(sRGBToneCurveToLinearFilter)
        
        if let i = imageView {
            i.image = image
        }
        
        collectionView.reloadData()
    }
    
}


//<Mark> collectionView datasource

extension FilterViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return filters.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        cell.image = thumbImage
        cell.filterObject = filters[indexPath.row]
        
        
        return cell
    }
    
}


//<Mark> colletionview delegate

extension FilterViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let f = filters[indexPath.row]
        navigationItem.title = f.dname
        filterN = f.dname
        
        if let i = image {
            imageView.image = createFilteredImage(filterObject: f, image: i)
        }
    }
    

    private func createFilteredImage(filterObject: Filter, image: UIImage) -> UIImage? {
        
        //handle normal one.
        if filterObject.name == "Normal" {return image}
        
        let context = CIContext(options: nil)
        // 1 - create source image
        let sourceImage = CIImage(image: image)
        
        // 2 - create filter using name
        if let filter = CIFilter(name: filterObject.name) {
            
            if filterObject.attribute != nil {
                filter.setValuesForKeys(filterObject.attribute!)
            }else{
                filter.setDefaults()
                if filter.name == "CIDotScreen" || filter.name == "CICMYKHalftone" {
                    
                    let w = Float(image.size.width / 414.0)
                    
                    filter.setValue(NSNumber(value: w), forKey: "inputWidth")
                }

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









