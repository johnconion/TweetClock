//
//  FirstRun.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/25.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit

class FirstRun {
    static func execute(){
        defer {
            UserDefaultManager.setValue(key: .FirstRun, value: true)
        }
        UserDefaultManager.setValue(key: .TextRedColor, value: Float(1.0))
        UserDefaultManager.setValue(key: .TextGreenColor, value: Float(1.0))
        UserDefaultManager.setValue(key: .TextBlueColor, value: Float(1.0))
        UserDefaultManager.setValue(key: .BackgroundRedColor, value: Float(0.0))
        UserDefaultManager.setValue(key: .BackgroundGreenColor, value: Float(0.3))
        UserDefaultManager.setValue(key: .BackgroundBlueColor, value: Float(0.45))
        UserDefaults().set(false, forKey: PurchaseManager.Purcheses.adRemove.rawValue)
        AdTermUtil.shared.initAdRemoveDate()
    }
}
