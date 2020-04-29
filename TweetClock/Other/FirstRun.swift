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
        UserDefaultManager.setValue(key: .BackgroundGreenColor, value: Float(0.2))
        UserDefaultManager.setValue(key: .BackgroundBlueColor, value: Float(0.35))
        UserDefaultManager.setValue(key: .LoadTimelineInterval,value: 1.0)
    }
}
