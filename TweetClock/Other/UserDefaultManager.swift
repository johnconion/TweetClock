//
//  UserDefaultManager.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/25.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit

class UserDefaultManager {
    
    static func setValue(key:UserDefaultKey,value:Any){
        UserDefaults().setValue(value, forKey: key.rawValue)
    }
    
    static func getInt(key:UserDefaultKey)->Int{
        UserDefaults().integer(forKey: key.rawValue)
    }
    
    static func getFloat(key:UserDefaultKey)->Float{
        UserDefaults().float(forKey: key.rawValue)
    }
    
    static func getBool(key:UserDefaultKey)->Bool{
        UserDefaults().bool(forKey: key.rawValue)
    }
    
    static func getStringValue(key:UserDefaultKey)->String?{
        if UserDefaultManager.checkValue(key: key){
            return UserDefaults().string(forKey: key.rawValue)
        }else{
            return nil
        }
    }
    
    static func checkValue(key:UserDefaultKey)->Bool{
        if UserDefaults().object(forKey: key.rawValue) != nil{
            return true
        }else{
            return false
        }
    }
}
