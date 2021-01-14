//
//  Battery.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/25.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit

class Battery {
    
    func getBatteryPercentage() -> String{
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batRemain = UIDevice.current.batteryLevel
        return NSString(format: "%.0f", batRemain * 100) as String + "%"
    }
    
    func getBatteryStatus() -> BatteryStatus{
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batStatus: UIDevice.BatteryState = UIDevice.current.batteryState
        switch batStatus {
        case .charging:
            return .CHARGING
        default:
            return .NOT_CHARGING
        }
    }
        
    enum BatteryStatus {
        case CHARGING
        case NOT_CHARGING
    }
}
