//
//  Clock.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/25.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import SwiftDate

class Clock {
    
    private var date : Date { Date()}
    
    private func getFormatter(format:String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter
    }
    
    func getDateSting() -> String { getFormatter(format: "MM/dd").string(from: date) }
    
    func getTimeString() -> String { getFormatter(format: "HH:mm").string(from: date) }

}
