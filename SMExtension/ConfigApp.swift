//
//  ConfigApp.swift
//  APIMark2
//
//  Created by MacBook Pro on 17/2/4.
//  Copyright © 2017年 Huang Baoan. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase
import GoogleMobileAds

class ConfigApp {
    
    init() {
        
    }
    
    let main = ConfigApp()
    
    func config() {
        
        //Basic configure steps.
        
        FirebaseApp.configure()
        GADMobileAds.configure(withApplicationID: "ca-app-pub-9967850754867722~6893241494")
        
        //First run
        let def: UserDefaults = UserDefaults.standard
        
        if def.bool(forKey: "FirstRun") {
            
            //First Run Handles
            print("It is not first run the app.")
            
        }else{
            
            print("It is first run the app.")
            UserDefaults.standard.set(true, forKey: "FirstRun")
            UserDefaults.standard.synchronize()
            SMConfigDefult.shared.userInfo()
            
        }
        
        
        if def.bool(forKey: "persistenceEnabled") {
            //print("It is persistenceEnabled")
            //FIRDatabase.database().persistenceEnabled = true
            
        }
        
    }
}


class SMConfigDefult {
    
    static let shared = SMConfigDefult()
    
    func userInfo() {
        
        let ud: UserDefaults = UserDefaults.standard
        
        ud.set("新朋友", forKey: "name")
        ud.set("duid", forKey: "duid")
        ud.set("uid", forKey: "uid")
        ud.set("http://ryumac.oss-cn-shenzhen.aliyuncs.com/defult/LogoFull@1x.png", forKey: "avatar")
        ud.set("某处，CN", forKey: "city")
        ud.set("NONE", forKey: "dataKey")
        ud.set("我热爱地球并不是偶然", forKey: "sign")
        ud.set("NEO-0012", forKey: "grl")
        ud.set("20170326", forKey: "birthday")
        ud.set("@sweetman.cc", forKey: "acount")
        ud.set("热爱电台-小白鼠-地球人", forKey: "bage")
        
        ud.synchronize()
    }
    
}




