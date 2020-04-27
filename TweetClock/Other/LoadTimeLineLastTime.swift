//
//  LoadTimeLineLastTime.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/27.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import SwiftDate

class LoadTimeLineLastTime {
    static func inTerm() -> Bool {
        if let dateStr = UserDefaultManager.getStringValue(key: .LoadTimelineLastTime){
            if (Date() - dateStr.toISODate()!.date).minute! < 1 { // 1分以内にAPIを叩かないようにするd511
                return true
            }
        }
        return false
    }
    
    static func update() {
        UserDefaultManager.setValue(key: .LoadTimelineLastTime, value: Date().toISO())
    }
}
