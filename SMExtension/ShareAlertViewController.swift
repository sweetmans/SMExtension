//
//  ShareAlertViewController.swift
//  SMExtension
//
//  Created by MacBook Pro on 17/2/22.
//  Copyright © 2017年 Sweetman, Inc. All rights reserved.
//
import UIKit


class ShareAlertViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(view.frame)
        
        let v = UIView()
        v.backgroundColor = UIColor.red
        v.frame = CGRect(x: 0, y: 300, width: 414, height: 200)
        view.addSubview(v)
        
        
    }
    
}
