//
//  IntExtension.swift
//  In
//
//  Created by MacBook Pro on 2017/6/1.
//  Copyright © 2017年 Sweetman, Inc. All rights reserved.
//

import Foundation


extension Int {
    
    
    // MARK: - Social Time Formate
    func getSocialTimeFormateString() -> String {
        
        let now = Int(Date().timeIntervalSince1970)
        let sec = now - self
        
        //Seconds
        if sec < 60 {return "\(sec) seconds ago."}
        //Minutes
        if sec < 60 * 60 {return "\(sec / 60) minutes ago."}
        //Hours
        if sec < 60 * 60 * 24 {return "\(sec / (60*60)) hours ago."}
        //Days
        if sec < 60 * 60 * 24 * 7 {return "\(sec / (60 * 60 * 24)) days ago."}
        //Weeks
        if sec < 60 * 60 * 24 * 31 {return "\(sec / (60 * 60 * 24 * 7)) weeks ago."}
        //Months
        if sec < 60 * 60 * 24 * 31 * 12 {return "\(sec / (60 * 60 * 24 * 31)) months ago."}
        //Time formate
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "yyyy-MM-dd'  'HH:mm"
        
        return dateFormate.string(from: date)
        
    }
    
    // MARK: - 1000 radix steps
    
    func get1000RadixString() -> String {
        
        if self < 1000{return "\(self)"}
        
        if self < 1000 * 1000{return String(format: "%.2fk", (CGFloat(self) / 1000.00))}
        if self < 1000 * 1000 * 1000 {return String(format: "%.2fm", (CGFloat(self) / 1000.0 / 1000.0))}
        if self < 1000 * 1000 * 1000 * 1000 {
            return String(format: "%.2fb", (CGFloat(self) / 1000.0 / 1000.0 / 1000 ))
        }
        
        return String(format: "%.2fb", (CGFloat(self) / 1000.0 / 1000.0 / 1000 ))
    }
    
}












