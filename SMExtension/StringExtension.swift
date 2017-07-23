//
//  StringExtension.swift
//  In
//
//  Created by MacBook Pro on 2017/6/1.
//  Copyright © 2017年 Sweetman, Inc. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    // MARK: - device UUID
    static var deviceUUID: String? {return UIDevice.current.identifierForVendor?.uuidString}
    
    func getIPSString() -> String? {
        //        中国移动号段：134、135、136、137、138、139、150、151、152、157、158、159、147、182、183、184、187、188、1705、178
        //        中国联通号段：130、131、132、145（145属于联通无线上网卡号段）、155、156、185、186 、176、1709、171[1]
        //        中国电信号段：133 、153 、180 、181 、189、1700、177
        let ISPs: [String: String] = [
            "134": "中国移动", "135": "中国移动", "137": "中国移动", "138": "中国移动", "139": "中国移动", "150": "中国移动", "151": "中国移动", "152": "中国移动", "157": "中国移动", "158": "中国移动", "159": "中国移动", "147": "中国移动", "182": "中国移动", "183": "中国移动", "184": "中国移动", "187": "中国移动", "188": "中国移动", "178": "中国移动",
            "130": "中国联通", "131": "中国联通", "132": "中国联通", "145": "中国联通", "155": "中国联通", "156": "中国联通", "185": "中国联通", "186": "中国联通", "176": "中国联通", "171": "中国联通",
            "133": "中国电信", "153": "中国电信", "180": "中国电信", "181": "中国电信", "189": "中国电信", "177": "中国电信"
        ]
        
        
        if self.characters.count >= 3 {
            let str =  self.substring(to: self.index(self.startIndex, offsetBy: 3))
            
            if let celler = ISPs[str] {
                
                return celler
            }

        }
        
        return "手机号码输入有错"
    }
}

