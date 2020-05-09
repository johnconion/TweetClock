//
//  UserStatus.swift
//  meen
//
//  Created by Ryosuke Tamura on 2019/08/01.
//  Copyright © 2019 Ryosuke Tamura. All rights reserved.
//

import UIKit

class AdTermUtil: NSObject {
    
    // 自動的に遅延初期化される(初回アクセスのタイミングでインスタンス生成)
    static let shared = AdTermUtil()
    // 外部からのインスタンス生成をコンパイルレベルで禁止
    private override init() {}
    
    private let userDefaults = UserDefaults()
    private let calendar = Calendar(identifier: .gregorian)
    
    var adRemove:Bool{
        get{
            return !checkAdRemoveDateOver()
        }
    }
    
    private func getAdRemoveDate()->Date?{
        if userDefaults.object(forKey: "adRemoveDate") != nil{
            return Date(timeIntervalSince1970: userDefaults.double(forKey: "adRemoveDate"))
        }else{
            return nil
        }
    }
    
    func addAdRemoveDate(){
        let today = calendar.startOfDay(for: Date())
        let after7Days = calendar.date(byAdding: .day, value: 7, to: today)
        userDefaults.set(after7Days?.timeIntervalSince1970, forKey: "adRemoveDate")
    }
    
    func initAdRemoveDate(){
        let today = calendar.startOfDay(for: Date())
        let after7Days = calendar.date(byAdding: .day, value: 6, to: today) // 1週間後にする
        if userDefaults.object(forKey: "adRemoveDate") == nil{
            userDefaults.set(after7Days?.timeIntervalSince1970, forKey: "adRemoveDate")
        }
    }
    
    func getAdRemoveTermDay()->Int?{
        let today = calendar.startOfDay(for: Date())
        if let day = getAdRemoveDate(){
            return calendar.dateComponents([.day], from: today, to: day).day
        }else{
            return nil
        }
    }
    
    // 値が存在しないときはオーバーしたものとして扱う
    private func checkAdRemoveDateOver()->Bool{
        if let term = getAdRemoveTermDay(){
            if term < 0{
                return true
            }else{
                return false
            }
        }
        return true
    }
}
