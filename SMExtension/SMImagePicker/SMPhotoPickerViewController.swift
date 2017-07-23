//
//  SMPhotoPickerViewController.swift
//  SMInstagramPhotosPicker
//
//  Created by MacBook Pro on 2017/4/18.
//  Copyright © 2017年 Sweetman, Inc. All rights reserved.
//

import UIKit
import Photos

public protocol SMPhotoPickerViewControllerDelegate: AnyObject{
    func didFinishPickingPhoto(image: UIImage, meteData: [String: Any])
    func didCancelPickingPhoto()
}

class SMPhotoPickerViewController: UIViewController, SMPhotoPickerAlbumViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var selectAlbumButton: UIButton!
    @IBOutlet weak var bottomToolsView: UIView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var albumView = SMPhotoPickerAlbumView.instance()
    let library: SMPhotoPickerLibraryView = SMPhotoPickerLibraryView.instance()
    
    public weak var delegate: SMPhotoPickerViewControllerDelegate? = nil
    var filterMode: Bool = false
    
    deinit {
        print("Picker deinit")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        getAuthorizationStatue { (auth) in
            if !auth {
                print("User can not assecc photolibrary.")
                return
            }
        }
        
        library.frame = scrollView.frame
        library.collectionView.reloadData()
        scrollView.addSubview(library)
        
        let title = "All Photos"
        selectAlbumButton.setTitle(title, for: .normal)
        let si = selectAlbumButton.titleLabel?.intrinsicContentSize
        selectAlbumButton.updateConstraint(attribute: .width, value: (si?.width)!)
        
        
        arrowImageView.image = UIImage(named: "arrowDown.png", in: Bundle(for: self.classForCoder), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        
        dealAlbum()
        
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        item.tintColor = UIColor.black
        navigationItem.backBarButtonItem = item
    }
    
    
    private func dealAlbum(){
        
        albumView.delegate = self
        albumView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height)
        view.addSubview(self.albumView)
        
    }
    
    @IBAction func showAlbum(_ sender: UITapGestureRecognizer) {
        
        // handle show album list
        if !selectAlbumButton.isSelected {
            selectAlbumButton.isSelected = true
            
            showAlbumView()
        }else {
            selectAlbumButton.isSelected = false
            hidnAlbumView()
        }
        
    }
    
    @IBOutlet weak var toolbarBottomConstraint: NSLayoutConstraint!
    
    private func showAlbumView() {
        
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            
            weak var me = self
            me?.toolbarBottomConstraint.constant = -44.0
            me?.view.layoutIfNeeded()
        })
        
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3,
                       delay: 0.3,
                       usingSpringWithDamping: 12,
                       initialSpringVelocity: 12,
                       options: .layoutSubviews,
                       animations: {
                        
                        weak var me = self
                        
                        me?.albumView.frame = CGRect(x: 0, y: 0, width:  self.view.frame.width, height:  self.view.frame.height)
                        me?.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                        
                        me?.cancelButton.isHidden = true
                        me?.nextButton.isHidden = true
                        me?.view.layoutIfNeeded()
        },
                       completion:nil)
    }
    
    private func hidnAlbumView() {
        
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            
            weak var me = self
            me?.albumView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height - 44.0)
            me?.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
            me?.cancelButton.isHidden = false
            me?.nextButton.isHidden = false
            me?.view.layoutIfNeeded()
        })
        
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3,
                       delay: 0.3,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .layoutSubviews,
                       animations: {
                        weak var me = self
                        me?.toolbarBottomConstraint.constant = 0
                        me?.view.layoutIfNeeded()
        },
                       completion: nil
        )
    }
    
    @IBAction func next(_ sender: UIButton) {
        
        if library.isOnDownloadingImage {
            
            let alert = UIAlertController.init(title: "Photo is downloading", message: "Please wait.", preferredStyle: .alert)
            let cancel = UIAlertAction.init(title: "Got it.", style: .cancel, handler: { (action) in
                
            })
            
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            
        }else{
            
            let image = library.imageView.image!.crop(rect: library.scaleRect, scale: library.imageScale / library.scale)
            let ass = library.currentAsset!
            var mateData: [String: Any] = [String: Any]()
            mateData["mediaType"] = ass.mediaType
            mateData["mediaSubtypes"] = ass.mediaSubtypes
            mateData["size"] = CGSize(width: ass.pixelWidth, height: ass.pixelHeight)
            mateData["creationTimestamp"] = Int((ass.creationDate?.timeIntervalSince1970)!)
            mateData["location"] = ass.location
            mateData["sourceType"] = ass.sourceType
            
            if filterMode {
                
                let b = Bundle(for: self.classForCoder)
                let sb = UIStoryboard(name: "Picker", bundle: b)
                if let filter = sb.instantiateViewController(withIdentifier: "Filter") as? FilterViewController {
                    
                    filter.image = image
                    filter.info = mateData
                    navigationController?.show(filter, sender: nil)
                }
                
            }else{
                
                delegate?.didFinishPickingPhoto(image: image, meteData: mateData)
                dismiss(animated: true, completion: nil)
                
            }
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        delegate?.didCancelPickingPhoto()
        dismiss(animated: true, completion: nil)
    }
    
    override public var prefersStatusBarHidden : Bool {return true}
    
    func didSeletctAlbum(album: AlbumModel) {
        
        selectAlbumButton.setTitle(album.name, for: .normal)
        let si = selectAlbumButton.titleLabel?.intrinsicContentSize
        selectAlbumButton.updateConstraint(attribute: .width, value: (si?.width)!)
        
        library.images = album.assets
        library.collectionView.reloadData()
        library.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .bottom)
        album.fetchFirstImage { (image) in
            weak var me = self
            me?.library.setupFirstLoadingImageAttrabute(image: image)
            
        }
        
        hidnAlbumView()
        
    }
    
    
    func getAuthorizationStatue(authorized: @escaping (Bool) -> Void) {
        
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == .authorized {
                    authorized(true)
                }else{
                    authorized(false)
                }
            })
            
        }else{
            authorized(true)
        }
        
    }
}










